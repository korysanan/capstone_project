import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'Messages.dart';
import '../globals.dart' as globals;

class chatbot extends StatefulWidget {
  const chatbot({Key? key}) : super(key: key);

  @override
  _chatbotState createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  bool isFirstMessageSent = false;
  bool isAwaitingResponse = false;

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(globals.getText('ChatBot')),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'),
          ),
        ],
      ),
      body: Column(
        children: [
          if (!isFirstMessageSent)
            buildInitialScreen(),
          Expanded(
            child: MessagesScreen(messages: messages),
          ),
          buildInputArea(),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildInitialScreen() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/korea_background.png',
            width: 300,
            height: 300,
          ),
          Text('Ask me anything...',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              )),
        ],
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      color: Color.fromARGB(255, 145, 214, 248),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: globals.getText('Message Chatbot'),
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              sendMessage(_controller.text);
              _controller.clear();
            },
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        isFirstMessageSent = true;
        isAwaitingResponse = true;
        addMessage(Message(text: DialogText(text: [text])), true);
        addMessage(Message(text: DialogText(text: ['Chatbot is typing...'])), false); // Add typing indicator
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      await Future.delayed(Duration(seconds: 1)); // Simulate typing delay
      setState(() {
        isAwaitingResponse = false;
        messages.removeLast(); // Remove typing indicator
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
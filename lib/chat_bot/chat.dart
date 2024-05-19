import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'Messages.dart';

class chatbot extends StatefulWidget {
  const chatbot({Key? key}) : super(key: key);

  @override
  _chatbotState createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  bool isFirstMessageSent = false;

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,  // 키보드에 의해 UI가 조정되도록 설정
      appBar: AppBar(
        title: Text('ChatBot'),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: Column(
        children: [
          if (!isFirstMessageSent) // 메시지가 전송되지 않은 경우에만 초기 화면 표시
            buildInitialScreen(),
          Expanded( // 메시지 스크린이나 초기 화면 대신 Expanded 위젯을 사용
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
            width: 300,  // 너비 설정
            height: 300,  // 높이 설정
          ),
          Text('Ask me anything...',
              style: TextStyle(
                fontSize: 30, 
                color: Colors.black, 
                fontStyle: FontStyle.italic
                )
              ),
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
                hintText: "Message Chatbot",
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
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}

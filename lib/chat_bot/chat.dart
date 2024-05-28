import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import '../translate/language_detect.dart';
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
    DialogFlowtter.fromFile().then((instance) {
      dialogFlowtter = instance;
      showAlertDialog(); // Show AlertDialog on init
    });
    super.initState();
  }

  void showAlertDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(globals.getText('Cautions (1/2)')),
            content: Text(globals.getText('This chatbot uses translations. Some translations may be slightly inaccurate, resulting in inappropriate results.')),
            actions: <Widget>[
              TextButton(
                child: Text(globals.getText('Next')),
                onPressed: () {
                  Navigator.of(context).pop();
                  showAlertDialog2();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void showAlertDialog2() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(globals.getText('Cautions (2/2)')),
            content: Text(globals.getText("You can only answer questions about apps and Korean food, and in the food category, you can only answer 27 questions about Korean food. The list of 27 foods can be found on the following page, or by asking the chatbot for a list of Korean foods.")),
            actions: <Widget>[
              TextButton(
                child: Text(globals.getText('Previous')),
                onPressed: () {
                  Navigator.of(context).pop();
                  showAlertDialog();
                },
              ),
              TextButton(
                child: Text(globals.getText('Next')),
                onPressed: () {
                  Navigator.of(context).pop();
                  showAlertDialog3();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void showAlertDialog3() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(globals.getText('Food Category')),
            content: Text(globals.getText("1. Etc \n2. Roasted\n3. Soup\n4. Kimchi\n5. Herbs\n6. Rice cake\n7. Dumpling\n8. Noodles\n9. Seasoned\n10. Rice\n11. Stir-fried\n12. Wraps\n13. Beverages\n14. Marinated Crab\n15. Pickles\n16. Skewer\n17. Pancake\n18. Hot Pot\n19. Braised\n20. Porridge\n21. Stews\n22. Steamed\n23. Soup\n24. Fries\n25. Sweets\n26. Seafood\n27. Raw fish")),
            actions: <Widget>[
              TextButton(
                child: Text(globals.getText('Previous')),
                onPressed: () {
                  Navigator.of(context).pop();
                  showAlertDialog2();
                },
              ),
              TextButton(
                child: Text(globals.getText('Confirm')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
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
      body: SafeArea(
        child: Column(
          children: [
            if (!isFirstMessageSent) buildInitialScreen(),
            Expanded(
              child: MessagesScreen(messages: messages),
            ),
            buildInputArea(),
          ],
        ),
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
            width: 200,
            height: 200,
          ),
          Text(
            'Ask me about Korean food...',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black.withOpacity(0.4), // Adjust the opacity here
              fontStyle: FontStyle.italic,
            ),
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
                hintText: globals.getText('Message Chatbot'),
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              String text = _controller.text;
              if (text.isNotEmpty) {
                // Show the user's original message
                addMessage(Message(text: DialogText(text: [text])), true);
                _controller.clear();

                // Translate the message
                String translatedText = await translateTextToEnglish(text);

                // Send the translated message
                sendMessage(translatedText);
              }
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
        addMessage(Message(text: DialogText(text: ['Chatbot is typing...'])), false); // Add typing indicator
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;

      // Extract and translate the response message
      String? originalResponseText = response.message?.text?.text?.first;
      if (originalResponseText != null) {
        String translatedResponseText = await translateText(originalResponseText);

        await Future.delayed(Duration(seconds: 1)); // Simulate typing delay
        setState(() {
          isAwaitingResponse = false;
          messages.removeLast(); // Remove typing indicator
          addMessage(Message(text: DialogText(text: [translatedResponseText])));
        });
      } else {
        setState(() {
          isAwaitingResponse = false;
          messages.removeLast(); // Remove typing indicator
        });
      }
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    setState(() {
      messages.add({'message': message, 'isUserMessage': isUserMessage});
    });
  }
}

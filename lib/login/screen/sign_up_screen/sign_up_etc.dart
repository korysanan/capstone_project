import 'package:capstone_project/login/screen/sign_up_screen/language_list.dart';
import 'package:flutter/material.dart';

import '../../service/sign_up_server.dart';

class SignUpEtcScreen extends StatefulWidget {
  final String email;
  final String password;

  SignUpEtcScreen({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  _SignUpEtcScreenState createState() => _SignUpEtcScreenState();
}

class _SignUpEtcScreenState extends State<SignUpEtcScreen> {
  final TextEditingController _nicknameController = TextEditingController();

  bool _isNicknameChecked = false;
  bool _isNicknameFieldEnabled = true;
  bool _isSignUpButtonEnabled = false;  // Initially, the Sign Up button is disabled

  String _selectedLanguageId = '18'; // Default selected language ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'K-Food Box',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50.0),
            CustomTextFieldWithButton(
              controller: _nicknameController,
              fieldEnabled: _isNicknameFieldEnabled,
              label: 'Nickname',
              isNicknameChecked: _isNicknameChecked,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Duplicate check'),
              onPressed: _isNicknameFieldEnabled ? _checkNicknameExistence : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            buildDropdownField(_selectedLanguageId, (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLanguageId = newValue;
                });
              }
            }),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Sign Up'),
              onPressed: _isSignUpButtonEnabled ? () async {
                await registerUser(
                  context,
                  widget.email,
                  widget.password,
                  _nicknameController.text,
                  int.tryParse(_selectedLanguageId) ?? 1
                );
              } : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color.fromARGB(255, 197, 165, 239),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkNicknameExistence() {
    String nickname = _nicknameController.text;
    if (nickname.isEmpty || nickname.length > 8) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Nickname Length"),
            content: Text("The nickname length must be between 1 and 8 characters."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    checkNicknameExistence(nickname).then((isExist) {
      if (!isExist) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Nickname Available"),
              content: Text("The nickname is available. Do you want to use this nickname?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context). pop();
                  },
                ),
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    setState(() {
                      _isNicknameChecked = true;
                      _isNicknameFieldEnabled = false;
                      _isSignUpButtonEnabled = true;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Duplicate Nickname"),
              content: Text("This nickname is already in use. Please enter a different nickname."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }).catchError((error) {
      print("An error occurred: $error");
    });
  }
}

class CustomTextFieldWithButton extends StatelessWidget {
  final TextEditingController controller;
  final bool fieldEnabled;
  final String label;
  final bool isNicknameChecked;

  const CustomTextFieldWithButton({
    Key? key,
    required this.controller,
    required this.fieldEnabled,
    required this.label,
    required this.isNicknameChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        enabled: fieldEnabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        ),
      ),
    );
  }
}

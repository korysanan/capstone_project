import 'package:capstone_project/design_test/sign_up_design/sign_up_screen/language_list.dart';
import 'package:flutter/material.dart';

class SignUpEtcScreen extends StatefulWidget {
  @override
  _SignUpEtcScreenState createState() => _SignUpEtcScreenState();
}

class _SignUpEtcScreenState extends State<SignUpEtcScreen> {
  final TextEditingController _nicknameController = TextEditingController();

  bool _isNicknameChecked = false; // 닉네임 중복 검사가 완료되었는지 확인하는 플래그
  bool _isNicknameFieldEnabled = true; // 닉네임 필드 활성화 여부

  String _selectedLanguageId = '18'; // 기본 선택 언어 ID

  @override
  void initState() {
    super.initState();
  }

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
              onPressed: (){},
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
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color.fromARGB(255, 197, 165, 239),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              onPressed: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpEtcScreen()),
                );
                */
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
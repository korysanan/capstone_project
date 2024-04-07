import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _selectedLanguage = 'English';
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _passwordError = '';

  
  // 비밀번호 유효성 검사
  bool _validatePassword(String password) {
    int typesIncluded = 0;

    if (RegExp(r'[A-Z]').hasMatch(password)) typesIncluded++; // 대문자
    if (RegExp(r'[a-z]').hasMatch(password)) typesIncluded++; // 소문자
    if (RegExp(r'[0-9]').hasMatch(password)) typesIncluded++; // 숫자
    if (RegExp(r'[\W]').hasMatch(password)) typesIncluded++; // 특수문자

    return password.length >= 8 && typesIncluded >= 2; // 8이상 조건 2개 이상
  }

/*
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 위치 고정하는거 -> 이거 x일시 만약 키보드 올라올때 각각들도 따라 올라옴 
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
            SizedBox(height: 32.0),
            _buildTextFieldWithButton(
              label: 'Email',
              buttonText: 'Duplicate check',
              onPressed: () {
                print('click Du');
              },
              buttonColor: Colors.yellow, 
            ),
            _buildTextFieldWithButton(
              label: 'Certification Number',
              buttonText: 'certification',
              onPressed: () {
                print('click cer');
              },
              buttonColor: Colors.blue,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                errorText: _passwordError.isNotEmpty ? _passwordError : null, // 비밀번호 검사 결과에 따라 에러 메시지 표시
              ),
              obscureText: true,
              onChanged: (value) {
                if (!_validatePassword(value)) {
                  setState(() => _passwordError = 'Invalid password format.');
                } else {
                  setState(() => _passwordError = '');
                }
              },
            ),
            _buildPasswordField('Password check'),
            SizedBox(height: 8.0),
            Text(
              'Password must contain special characters',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            _buildTextFieldWithButton(
              label: 'Nickname',
              buttonText: 'Duplicate check',
              onPressed: () {
                print('click Du2');
              },
              buttonColor: Colors.yellow, 
            ),
            _buildDropdownField(),
            SizedBox(height: 32.0),
            ElevatedButton(
              child: Text('Sign up'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
              onPressed: () {
                print("sign_up click");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithButton({
    required String label,
    required String buttonText,
    required VoidCallback onPressed,
    Color buttonColor = Colors.yellow,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: ElevatedButton(
            child: Text(buttonText),
            style: ElevatedButton.styleFrom(
              primary: buttonColor, // Use the buttonColor passed in as a parameter
              onPrimary: Colors.black, // Text color for the button
              textStyle: TextStyle(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            ),
            onPressed: onPressed,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label) {
    bool isPasswordCheckField = label.toLowerCase().contains('check');
    TextEditingController currentController = isPasswordCheckField ? _confirmPasswordController : _passwordController;

    return TextField(
      controller: currentController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: isPasswordCheckField
            ? (_passwordController.text == _confirmPasswordController.text && _confirmPasswordController.text.isNotEmpty
                ? Icon(Icons.check, color: Colors.green)
                : SizedBox.shrink())
            : null,
      ),
      obscureText: true,
      onChanged: isPasswordCheckField ? (_) => setState(() {}) : null,
    );
  }

  Widget _buildDropdownField() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Language',
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          items: ['English', 'Korean', 'Chinese', 'Japanese'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedLanguage = newValue;
              });
            }
          },
        ),
      ),
    );
  }
}

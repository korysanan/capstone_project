import 'dart:async';

import 'package:flutter/material.dart'; 

import 'sign_up_etc.dart';
import 'sign_up_screen/email_verification.dart';

class SignUpPasswordScreen extends StatefulWidget {
  @override
  _SignUpPasswordScreenState createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  EmailVerification? emailVerification;

  String _passwordError = '';

  bool _isPasswordVisible = false;
  bool _isButtonEnabled = false; // Control the enabled state of the button

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final bool passwordsMatch =
        _passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.isNotEmpty &&
        _validatePassword(_passwordController.text);
    setState(() {
      _isButtonEnabled = passwordsMatch;
    });
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
            SizedBox(height: 32.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                errorText: _passwordError.isNotEmpty ? _passwordError : null,
              ),
              obscureText: !_isPasswordVisible,
              onChanged: (value) {
                if (!_validatePassword(value)) {
                  setState(() => _passwordError = 'Invalid password format.');
                } else {
                  setState(() => _passwordError = '');
                }
              },
            ),
            SizedBox(height: 20.0),
            _buildPasswordField('Password check'),
            SizedBox(height: 10.0),
            Text(
              'Your password must be at least 8 characters long and contain at least two of the following: upper & lower case letters & numbers & special characters.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color.fromARGB(255, 197, 165, 239),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              onPressed: _isButtonEnabled ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpEtcScreen()),
                );
              } : null,
            ),
          ],
        ),
      ),
    );
  }

  bool _validatePassword(String password) {
    int typesIncluded = 0;
    if (RegExp(r'[A-Z]').hasMatch(password)) typesIncluded++;
    if (RegExp(r'[a-z]').hasMatch(password)) typesIncluded++;
    if (RegExp(r'[0-9]').hasMatch(password)) typesIncluded++;
    if (RegExp(r'[\W]').hasMatch(password)) typesIncluded++;
    return password.length >= 8 && typesIncluded >= 2;
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
            ? _passwordController.text == _confirmPasswordController.text && _confirmPasswordController.text.isNotEmpty
                ? Icon(Icons.check, color: Colors.green)
                : _confirmPasswordController.text.isNotEmpty
                    ? Icon(Icons.close, color: Colors.red)
                    : null
            : null,
      ),
      obscureText: true,
      onChanged: isPasswordCheckField ? (_) => _updateButtonState() : null,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
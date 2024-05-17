/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../login/service/login_service.dart'; // Import the login service
import '../../login/screen/sign_up_screen.dart';
import '../../home/main_screen.dart';

class LoginScreen extends StatelessWidget {
  //final TextEditingController emailController = TextEditingController();
  //final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController(text: "ujin0561@naver.com");
  final TextEditingController passwordController = TextEditingController(text: "dnwls0561");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'K-Food Box',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 48.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'EMAIL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Log in'),
              onPressed: () {
                if (_validateEmail(emailController.text)) {
                  LoginService.login(context, emailController.text, passwordController.text);
                } else {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Invalid Email'),
                      content: Text('Please enter a valid email address.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
            TextButton(
              child: Text('Forgot Password?'),
              onPressed: () {
                print('Forgot Password button pressed');
              },
            ),
            TextButton(
              child: Text('Need An account? SIGN UP'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
            SizedBox(height: 100.0),
            ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8.0),
                  Text(
                    'Guest Mode',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KFoodBoxHome()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[400],
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateEmail(String email) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
*/
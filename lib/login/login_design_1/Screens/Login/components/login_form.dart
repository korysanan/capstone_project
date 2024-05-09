import 'package:capstone_project/login/login/login_service.dart';
import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController = TextEditingController(text: "ujin0561@naver.com");
  final TextEditingController passwordController = TextEditingController(text: "dnwls0561");

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.blue,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
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
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(height: 150.0),
        ],
      ),
    );
  }
  
  bool _validateEmail(String email) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}

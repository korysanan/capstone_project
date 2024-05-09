import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Color.fromARGB(255, 117, 201, 243),
            onSaved: (email) {},
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
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Color.fromARGB(255, 117, 201, 243),
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: 16),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
import 'package:capstone_project/home/main_screen.dart';
import 'package:flutter/material.dart';

import '../../Login/login_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade300,
            elevation: 0,
          ),
          child: Text(
            "Login".toUpperCase(),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KFoodBoxHome()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade300,
            elevation: 0,
          ),
          child: Text(
            "Guest Mode".toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

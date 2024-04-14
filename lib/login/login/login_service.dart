import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../home/main_screen.dart';

class LoginService {
  // 로그인 서버 쪽
  static Future<void> login(BuildContext context, String email, String password) async {
    var response = await http.post(
      Uri.parse('http://api.kfoodbox.click/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Login Successful!'),
          );
        },
      );
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pop(); // Closes the dialog
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KFoodBoxHome()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Please check your email or password.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }
}
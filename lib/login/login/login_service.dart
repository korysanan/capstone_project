import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/main_screen.dart';
import 'login_screen.dart';

class LoginService {
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
      // 세션 ID 저장
      String? sessionId = response.headers['set-cookie'];
      if (sessionId != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionId', sessionId);
      }
      print("아이디 : $sessionId");

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

  static Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('sessionId');

    if (sessionId != null) {
      var response = await http.post(
        Uri.parse('http://api.kfoodbox.click/logout'), // 실제 로그아웃을 처리할 서버의 URI
        headers: {
          'Content-Type': 'application/json',
          'Cookie': sessionId, // 서버에 세션 ID 전송
        },
      );

      if (response.statusCode == 200) {
        print("성공?");
        // 서버 응답 성공 시 로컬 세션 ID 삭제
        await prefs.remove('sessionId');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // 로그인 화면으로 이동
        );
      } else {
        // 로그아웃 실패 처리, 에러 메시지를 보여주거나 로깅
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Logout Failed'),
              content: Text('Failed to logout. Please try again.'),
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
}

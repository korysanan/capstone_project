import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/main_screen.dart';
import 'login_screen.dart';
import '../../globals.dart' as globals; // Import globals

class LoginService {
  // 로그인 api 이용
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
      globals.sessionId = response.headers['set-cookie'];
      if (globals.sessionId != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionId', globals.sessionId!);
        // Fetch user_nickname
        await _fetchNickname();
        // Fetch user_email
        await _fetchEmail();
        // Fetch user_language
        await _fetchLanguage();
      }
      globals.setLanguageCode();
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

  // 자신의 닉네임 불러오기 api
  static Future<void> _fetchNickname() async {
    var response = await http.get(
      Uri.parse('http://api.kfoodbox.click/my-nickname'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': globals.sessionId!, // Send session ID in headers
      },
    );
    if (response.statusCode == 200) {
      globals.user_nickname = json.decode(response.body)['nickname']; // Assuming the nickname is returned in this manner
    }
  }

  // 자신의 이메일 불러오기 api
  static Future<void> _fetchEmail() async {
    var response = await http.get(
      Uri.parse('http://api.kfoodbox.click/my-email'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': globals.sessionId!, // Send session ID in headers
      },
    );
    if (response.statusCode == 200) {
      globals.user_email = json.decode(response.body)['email']; // Assuming the email is returned in this manner
    }
  }

  // 자신의 언어선택한거 불러오기 
  static Future<void> _fetchLanguage() async {
    var response = await http.get(
      Uri.parse('http://api.kfoodbox.click/my-language'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': globals.sessionId!, // Send session ID in headers
      },
    );
    if (response.statusCode == 200) {
      int userId = json.decode(response.body)['id'];
      globals.user_language = userId.toString();
    }
  }

  // 닉네임, 비밀번호 변경 api 불러오기 
  static Future<void> updateUser(BuildContext context, String nickname, String password) async {
    var url = Uri.parse('http://api.kfoodbox.click/user'); // Modify with your actual server URL
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': globals.sessionId!,
      },
      body: jsonEncode({
        'nickname': nickname,
        'password': password,
      }),
    );

    if (!Navigator.of(context).mounted) return;

    if (response.statusCode == 200) {
      if (!Navigator.of(context).mounted) return;  // Ensure the context is still valid before showing the dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User updated successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();  // Close the dialog
                  LoginService.logout(context);
                },
              ),
            ],
          );
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Fail'),
            content: Text('User updated fail'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  // 로그아웃 api
  static Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionId = prefs.getString('sessionId');

    if (sessionId != null) {
      var response = await http.post(
        Uri.parse('http://api.kfoodbox.click/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': sessionId,
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('sessionId');
        globals.sessionId = null;
        globals.user_nickname = null;
        globals.user_email = null;
        globals.user_language = null;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Logout Failed'),
              content: Text('Failed to logout. Please try again.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context). pop(),
                ),
              ],
            );
          },
        );
      }
    }
  }

  // 회원 탈퇴 기능 api 
  static Future<void> deleteUser(BuildContext context) async {
    var url = Uri.parse('http://api.kfoodbox.click/user');  // Modify with your actual server URL
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': globals.sessionId!,
      },
    );

    if (!Navigator.of(context).mounted) return;  // Check if the context is still valid

    if (response.statusCode == 200) {
      if (!Navigator.of(context).mounted) return;  // Ensure the context is still valid before showing the dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Account Deleted'),
            content: Text('Your account has been successfully deleted.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); 
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else{
      if (!Navigator.of(context).mounted) return;  // Ensure the context is still valid before showing the dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Deletion Failed'),
            content: Text('Failed to delete account: ${response.body}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();  // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
}

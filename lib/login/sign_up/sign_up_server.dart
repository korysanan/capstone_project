import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:capstone_project/login/login/login_screen.dart';

Future<void> sendVerificationCode(BuildContext context, String email) async { // 인증번호 보내기
  const String serverAddress = 'http://api.kfoodbox.click/authentication-number';
  try {
    final response = await http.post(
      Uri.parse(serverAddress),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification code sent successfully.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send verification code.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error sending verification code: $e")),
    );
  }
}

Future<bool> verifyCertificationNumber(BuildContext context, String email, String certificationNumber) async {
  const String serverAddress = 'http://api.kfoodbox.click/signup-authentication';

  try {
    final response = await http.post(
      Uri.parse(serverAddress),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'authenticationNumber': certificationNumber,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Certification number verified successfully.")),
      );
      return true; // 인증 성공 시 true 반환
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to verify certification number.")),
      );
      return false; // 인증 실패 시 false 반환
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error verifying certification number: $e")),
    );
    return false; // 오류 발생 시 false 반환
  }
}

Future<bool> checkNicknameExistence(String nickname) async { // 닉네임 중복 체크 
  final Uri url = Uri.parse('http://api.kfoodbox.click/nickname-existence?nickname=$nickname');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['isExist'];
  } else {
    throw Exception('Failed to load nickname existence');
  }
}

Future<bool> checkEmailExistence(String email) async { // 닉네임 중복 체크 
  final Uri url = Uri.parse('http://api.kfoodbox.click/email-existence?email=$email');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['isExist'];
  } else {
    throw Exception('Failed to load email existence');
  }
}

Future<void> registerUser(BuildContext context, String email, String password, String nickname, int languageId) async {
  const String serverAddress = 'http://api.kfoodbox.click/user';
  try {
    final response = await http.post(
      Uri.parse(serverAddress),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
        'nickname': nickname,
        'languageId': languageId,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration Successful"),
            content: Text("You have been successfully registered."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration successful.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to register.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error during registration: $e")),
    );
  }
}
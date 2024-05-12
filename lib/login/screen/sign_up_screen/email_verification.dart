import 'package:flutter/material.dart';
import 'package:capstone_project/login/service/sign_up_server.dart';// Update this path as necessary

class EmailVerification {
  final BuildContext context;
  final TextEditingController emailController;
  final Function(bool) updateCertificationCodeEnabled;
  final Function(bool) updateTimerVisible;
  final Function startTimer;  // 타이머 시작 함수

  EmailVerification({
    required this.context,
    required this.emailController,
    required this.updateCertificationCodeEnabled,
    required this.updateTimerVisible,
    required this.startTimer,  // 생성자를 통해 전달받음
  });

  void checkEmailAndSendVerification() {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    final email = emailController.text;

    if (!emailRegExp.hasMatch(email)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Email Format"),
            content: Text("Please enter a valid email address."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    checkEmailExistence(email).then((isExist) {
      if (!isExist) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Send Verification Code"),
              content: Text("This email is available. Would you like to send a verification code?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Send"),
                  onPressed: () async {
                    await sendVerificationCode(context, email);
                    Navigator.of(context).pop();
                    startTimer();  // 여기서 타이머를 시작합니다
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Email Duplicate"),
              content: Text("This email is already in use. Please use a different email."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }).catchError((error) {
      print("An error occurred: $error");
    });
  }
}
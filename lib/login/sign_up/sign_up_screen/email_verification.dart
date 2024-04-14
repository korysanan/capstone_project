import 'package:flutter/material.dart';
import 'package:capstone_project/login/sign_up/sign_up_server.dart';// Update this path as necessary

class EmailVerification {
  final BuildContext context;
  final TextEditingController emailController;
  final Function(bool) updateCertificationCodeEnabled;
  final Function(bool) updateTimerVisible;
  final Function startTimer;

  EmailVerification({
    required this.context,
    required this.emailController,
    required this.updateCertificationCodeEnabled,
    required this.updateTimerVisible,
    required this.startTimer,
  });

  void checkEmailAndSendVerification() {
    // Email format verification regular expression
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    // Retrieve the entered email
    final email = emailController.text;

    // Check email format
    if (!emailRegExp.hasMatch(email)) {
      // If format is incorrect, display warning dialog
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
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
            ],
          );
        },
      );
      return; // Exit function if email format is incorrect
    }
    checkEmailExistence(email).then((isExist) {
      if (!isExist) { // If email is not duplicated
        // Ask if user wants to send a verification code
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
                    Navigator.of(context).pop(); // Close dialog on cancel
                  },
                ),
                TextButton(
                  child: Text("Send"),
                  onPressed: () async {
                    await sendVerificationCode(context, email); // Wait to send verification code
                    updateCertificationCodeEnabled(true);
                    updateTimerVisible(true);
                    startTimer();
                    Navigator.of(context).pop(); // Close dialog after sending
                  },
                ),
              ],
            );
          },
        );
      } else { // If email is duplicated
        // Notify user of duplication
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
      // Handle errors
      print("An error occurred: $error");
    });
  }
}

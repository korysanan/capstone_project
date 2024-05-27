import 'dart:async';
import 'package:capstone_project/login/service/sign_up_server.dart';
import 'package:flutter/material.dart';
import 'sign_up_password.dart';
import 'email_verification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
      theme: ThemeData(fontFamily: 'Jalnan'),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _certificationNumberController = TextEditingController();

  EmailVerification? emailVerification;

  bool _isCertificationNumberVerified = false;
  bool _isEmailFieldEnabled = true;
  bool _isCertificationCodeEnabled = true;
  bool _isTimerVisible = false;
  bool _isEmailVerified = false;
  bool _showCertificationSection = false;  // 인증 번호 섹션 표시 여부

  Timer? _timer;
  int _remainingTime = 300;

  @override
  void initState() {
    super.initState();
    emailVerification = EmailVerification(
      context: context,
      emailController: _emailController,
      updateCertificationCodeEnabled: (bool isEnabled) {
        setState(() => _isCertificationCodeEnabled = isEnabled);
      },
      updateTimerVisible: (bool isVisible) {
        setState(() => _isTimerVisible = isVisible);
      },
      startTimer: _startTimer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'K-Food Box',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50.0),
            CustomTextFieldWithButton(
              controller: _emailController,
              fieldEnabled: _isEmailFieldEnabled,
              label: 'Email',
              isEmailVerified: _isEmailVerified,
              isTimerVisible: _isTimerVisible,
              remainingTime: _remainingTime,
              isCertificationNumberVerified: _isCertificationNumberVerified
            ),
            SizedBox(height: 10),
            _isTimerVisible
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Remaining Time: $_remainingTime s', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      emailVerification!.checkEmailAndSendVerification();
                    },
                    child: Text('Re-Send'),
                  ),
                ],
              )
              : ElevatedButton(
                  child: Text('Duplicate check'),
                  onPressed: () {
                    emailVerification!.checkEmailAndSendVerification();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                ),
            SizedBox(height: 30),
            if (_showCertificationSection) ...[
              CustomTextFieldWithButton(
                controller: _certificationNumberController,
                fieldEnabled: _isCertificationCodeEnabled,
                label: 'Certification Number',
                isEmailVerified: _isEmailVerified,
                isTimerVisible: _isTimerVisible,
                remainingTime: _remainingTime,
                isCertificationNumberVerified: _isCertificationNumberVerified
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromARGB(255, 197, 165, 239),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                onPressed: () async {
                  bool result = await verifyCertificationNumber(context, _emailController.text, _certificationNumberController.text);
                  if (result) {
                    // 성공 시 AlertDialog를 통해 사용자에게 알립니다.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Verification Success'),
                          content: Text('Your certification number is verified successfully!'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPasswordScreen(
                                      email: _emailController.text, 
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // 실패 시 AlertDialog를 통해 사용자에게 알립니다.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Verification Failed'),
                          content: Text('Please check your certification number and try again.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _verifyCertificationNumber() async {
    bool verified = await verifyCertificationNumber(context, _emailController.text, _certificationNumberController.text);
    if (verified) {
      setState(() {
        _isEmailFieldEnabled = false;
        _isCertificationCodeEnabled = false;
        _isCertificationNumberVerified = true;
        _isEmailVerified = true;
        _isTimerVisible = false;
        _timer?.cancel();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Verification Failed"),
            content: Text("The verification number is incorrect. Would you like to send a new verification code?"),
            actions: <Widget>[
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Send"),
                onPressed: () async {
                  await sendVerificationCode(context, _emailController.text);
                  setState(() {
                    _startTimer();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  
  void _startTimer() {
    setState(() {
      _isTimerVisible = true;
      _remainingTime = 300; // 타이머 시간을 초기화
      _showCertificationSection = true;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        timer.cancel();
        setState(() => _isTimerVisible = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class CustomTextFieldWithButton extends StatelessWidget {
  final TextEditingController controller;
  final bool fieldEnabled;
  final String label;
  final bool isEmailVerified;
  final bool isTimerVisible;
  final int remainingTime;
  final bool isCertificationNumberVerified;

  const CustomTextFieldWithButton({
    Key? key,
    required this.controller,
    required this.fieldEnabled,
    required this.label,
    required this.isEmailVerified,
    required this.isTimerVisible,
    required this.remainingTime,
    required this.isCertificationNumberVerified,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        enabled: fieldEnabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        ),
      ),
    );
  }
}

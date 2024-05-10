import 'dart:async';

import 'package:capstone_project/login/service/sign_up_server.dart';
import 'package:flutter/material.dart';

import 'sign_up_screen/email_verification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpScreen(),
      theme: ThemeData(fontFamily: 'Jalnan'),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _certificationNumberController =
      TextEditingController();

  EmailVerification? emailVerification;

  bool _isCertificationNumberVerified = false; // 인증번호 검증 여부를 저장하는 변수
  bool _isEmailFieldEnabled = true; // 이메일 필드 입력 가능 여부 저장하는 변수
  bool _isCertificationCodeEnabled = false; // 인증번호 필드 입력 가능 여부 저장하는 변수
  bool _isTimerVisible = false; // 타이머 보여지고 숨겨지기 여부
  bool _isEmailVerified = false; // 이메일 인증 성공 여부

  Timer? _timer; // 타이머를 참조할 변수
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
      resizeToAvoidBottomInset:
          false, // 위치 고정하는거 -> 이거 x일시 만약 키보드 올라올때 각각들도 따라 올라옴
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'K-Food Box',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50.0),
            CustomTextFieldWithButton(
                controller: _emailController,
                fieldEnabled: _isEmailFieldEnabled,
                label: 'Email',
                /*
              buttonText: 'Duplicate check',
              onPressed: emailVerification!.checkEmailAndSendVerification,  // Use the EmailVerification method
              buttonColor: Colors.yellow,
              */
                isEmailVerified: _isEmailVerified,
                isTimerVisible: _isTimerVisible,
                remainingTime: _remainingTime,
                isCertificationNumberVerified: _isCertificationNumberVerified),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Do something
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue, // Text color
                backgroundColor: Colors.white, // Button background color
                shape: const RoundedRectangleBorder(
                  // Define the shape of the button.
                  borderRadius: BorderRadius
                      .zero, // Makes the button a perfect rectangle.
                  side: BorderSide(
                      color: Colors.blue,
                      width:
                          2.0), // Adds a blue border with a width of 2.0 units.
                ),
              ),
              child: const Text('Duplicate check'),
            ),
            const SizedBox(height: 30),
            CustomTextFieldWithButton(
                controller: _certificationNumberController,
                fieldEnabled: _isCertificationCodeEnabled,
                label: 'Certification Number',
                isEmailVerified: _isEmailVerified,
                isTimerVisible: _isTimerVisible,
                remainingTime: _remainingTime,
                isCertificationNumberVerified: _isCertificationNumberVerified),
            const SizedBox(height: 32.0),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Text color
                  backgroundColor: Colors.purple, // Button background color
                  shape: const RoundedRectangleBorder(
                    // Define the shape of the button.
                    borderRadius: BorderRadius
                        .zero, // Makes the button a perfect rectangle.
                    side: BorderSide(
                        color: Colors.black,
                        width:
                            2.0), // Adds a blue border with a width of 2.0 units.
                  ),
                ),
                onPressed: () {
                  print("hello");
                },
                child: const Text('Next')),
          ],
        ),
      ),
    );
  }

  void _verifyCertificationNumber() async {
    bool verified = await verifyCertificationNumber(
        context, _emailController.text, _certificationNumberController.text);
    if (verified) {
      setState(() {
        _isEmailFieldEnabled = false; // 이메일 필드 비활성화
        _isCertificationCodeEnabled = false; // 인증 번호 필드 비활성화
        _isCertificationNumberVerified = true; // 인증 번호 검증 성공
        _isEmailVerified = true; // 이메일 인증 성공
        _isTimerVisible = false; // 타이머 숨기기
        _timer?.cancel(); // 타이머 중지
      });
    } else {
      // 인증 실패 혹은 오류 시 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Verification Failed"),
            content: const Text(
                "The verification number is incorrect. Would you like to send a new verification code?"),
            actions: <Widget>[
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
              ),
              TextButton(
                child: const Text("Send"),
                onPressed: () async {
                  await sendVerificationCode(
                      context, _emailController.text); // 인증번호 보내는 함수를 기다림
                  setState(() {
                    _startTimer();
                  });
                  Navigator.of(context).pop(); // 함수 실행 후 창을 닫음
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerVisible = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isTimerVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 위젯이 소멸될 때 타이머를 취소
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
          border: const OutlineInputBorder(),
          //suffixIcon: _buildSuffixIcon(),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
        ),
      ),
    );
  }

/*
  Widget _buildSuffixIcon() {
    if (isEmailVerified && label == "Email") {
      return _buildCheckIcon();
    } else if (isTimerVisible && label == "Email") {
      return _buildTimerText();
    } else{
      return _buildCheckIcon();
    }
  }

  Widget _buildCheckIcon() => SizedBox(
      width: 50,
      child: Icon(Icons.check, color: Colors.green),
  );
*/
  Widget _buildTimerText() => Padding(
        padding: const EdgeInsets.all(10),
        child: Text('$remainingTime s',
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold)),
      );
}

import 'dart:async';

import 'package:flutter/material.dart';
import '../../login/service/sign_up_server.dart';

import 'sign_up_screen/language_list.dart';
import 'sign_up_screen/custom_text_field.dart';
import 'sign_up_screen/email_verification.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); // 이메일 컨트롤러 추가
  final TextEditingController _certificationNumberController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  EmailVerification? emailVerification;

  String _passwordError = '';

  bool _isNicknameChecked = false; // 닉네임 중복 검사가 완료되었는지 확인하는 플래그
  bool _isCertificationNumberVerified = false; // 인증번호 검증 여부를 저장하는 변수
  bool _isEmailFieldEnabled = true; // 이메일 필드 입력 가능 여부 저장하는 변수
  bool _isCertificationCodeEnabled = false; // 인증번호 필드 입력 가능 여부 저장하는 변수
  bool _isTimerVisible = false; // 타이머 보여지고 숨겨지기 여부
  bool _isEmailVerified = false; // 이메일 인증 성공 여부
  bool _isPasswordFieldEnabled = false; // 비밀번호 및 비밀번호 확인 필드 활성화 여부
  bool _isPasswordVisible = false; // 비밀번호 가시성 제어 변수
  bool _isNicknameFieldEnabled = false; // 닉네임 필드 활성화 여부

  Timer? _timer; // 타이머를 참조할 변수
  int _remainingTime = 300;

  String _selectedLanguageId = '18'; // 기본 선택 언어 ID

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
      resizeToAvoidBottomInset: false, // 위치 고정하는거 -> 이거 x일시 만약 키보드 올라올때 각각들도 따라 올라옴 
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
            SizedBox(height: 32.0),
            CustomTextFieldWithButton(
              controller: _emailController,
              fieldEnabled: _isEmailFieldEnabled,
              label: 'Email',
              buttonText: 'Duplicate check',
              onPressed: emailVerification!.checkEmailAndSendVerification,  // Use the EmailVerification method
              buttonColor: Colors.yellow,
              isEmailVerified: _isEmailVerified,
              isTimerVisible: _isTimerVisible,
              remainingTime: _remainingTime,
              isNicknameChecked: _isNicknameChecked,
              isCertificationNumberVerified: _isCertificationNumberVerified
            ),
            CustomTextFieldWithButton(
              controller: _certificationNumberController,
              fieldEnabled: _isCertificationCodeEnabled,
              label: 'Certification Number',
              buttonText: 'Certification',
              onPressed: _verifyCertificationNumber,
              buttonColor: Colors.blue,
              isEmailVerified: _isEmailVerified,
              isTimerVisible: _isTimerVisible,
              remainingTime: _remainingTime,
              isNicknameChecked: _isNicknameChecked,
              isCertificationNumberVerified: _isCertificationNumberVerified
            ),
            TextField(
              controller: _passwordController,
              enabled: _isPasswordFieldEnabled, // 비밀번호 필드 활성화/비활성화 제어
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                // 여기에 아이콘 추가
                suffixIcon: IconButton(
                  icon: Icon(
                    // 비밀번호 가시성에 따라 아이콘 변경
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // 아이콘 버튼 클릭 시 동작: 비밀번호 가시성 상태 변경
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                errorText: _passwordError.isNotEmpty ? _passwordError : null,
              ),
              obscureText: !_isPasswordVisible, // 비밀번호 가시성 제어
              onChanged: (value) {
                if (!_validatePassword(value)) {
                  setState(() => _passwordError = 'Invalid password format.');
                } else {
                  setState(() => _passwordError = '');
                }
              },
            ),
            _buildPasswordField('Password check'),
            Text(
              'Password must contain special characters',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            SizedBox(height: 8.0),
            CustomTextFieldWithButton(
              controller: _nicknameController,
              fieldEnabled: _isNicknameFieldEnabled,
              label: 'Nickname',
              buttonText: 'Duplicate check',
              onPressed: _checkNicknameExistence,
              buttonColor: Colors.yellow,
              isEmailVerified: _isEmailVerified,  // This might not be needed for nickname but kept for consistency
              isTimerVisible: _isTimerVisible,    // This might not be needed for nickname but kept for consistency
              remainingTime: _remainingTime,      // This might not be needed for nickname but kept for consistency
              isNicknameChecked: _isNicknameChecked,
              isCertificationNumberVerified: _isCertificationNumberVerified  // This might not be needed for nickname but kept for consistency
            ),
            buildDropdownField(_selectedLanguageId, (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLanguageId = newValue;
                });
              }
            }),
            SizedBox(height: 32.0),
            ElevatedButton(
              child: Text('Sign up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // 'primary'를 'backgroundColor'로 변경
                padding: EdgeInsets.symmetric(vertical: 12.0)
              ),
              onPressed: _isEmailVerified && _isCertificationNumberVerified && _passwordController.text == _confirmPasswordController.text && _isNicknameChecked ? () async {
                await registerUser(
                  context,
                  _emailController.text,
                  _passwordController.text,
                  _nicknameController.text,
                  int.tryParse(_selectedLanguageId) ?? 1 // Assuming default languageId is 1 if parsing fails
                );
              } : null,
            ),
          ],
        ),
      ),
    );
  }

  void _verifyCertificationNumber() async {
    bool verified = await verifyCertificationNumber(context, _emailController.text, _certificationNumberController.text);
    if (verified) {
      setState(() {
        _isEmailFieldEnabled = false; // 이메일 필드 비활성화
        _isCertificationCodeEnabled = false; // 인증 번호 필드 비활성화
        _isCertificationNumberVerified = true; // 인증 번호 검증 성공
        _isEmailVerified = true; // 이메일 인증 성공
        _isTimerVisible = false; // 타이머 숨기기
        _timer?.cancel(); // 타이머 중지
        _isPasswordFieldEnabled = true; // 비밀번호 필드 활성화
        _isNicknameFieldEnabled = true; // 닉네임 필드 활성화
      });
    } else {
      // 인증 실패 혹은 오류 시 처리
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
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
              ),
              TextButton(
                child: Text("Send"),
                onPressed: () async {
                  await sendVerificationCode(context, _emailController.text); // 인증번호 보내는 함수를 기다림
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

  // 비밀번호 유효성 검사
  bool _validatePassword(String password) {
    int typesIncluded = 0;

    if (RegExp(r'[A-Z]').hasMatch(password)) typesIncluded++; // 대문자
    if (RegExp(r'[a-z]').hasMatch(password)) typesIncluded++; // 소문자
    if (RegExp(r'[0-9]').hasMatch(password)) typesIncluded++; // 숫자
    if (RegExp(r'[\W]').hasMatch(password)) typesIncluded++; // 특수문자

    return password.length >= 8 && typesIncluded >= 2; // 8이상 조건 2개 이상
  }

  Widget _buildPasswordField(String label) {
    bool isPasswordCheckField = label.toLowerCase().contains('check');
    TextEditingController currentController = isPasswordCheckField ? _confirmPasswordController : _passwordController;

    return TextField(
      controller: currentController,
      enabled: _isPasswordFieldEnabled, // 비밀번호 필드 활성화/비활성화 제어
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        // 비밀번호 확인 필드에서 비밀번호가 일치하면 체크 아이콘, 불일치하면 X 아이콘 표시
        suffixIcon: isPasswordCheckField
            ? _passwordController.text == _confirmPasswordController.text && _confirmPasswordController.text.isNotEmpty
                ? Icon(Icons.check, color: Colors.green) // 비밀번호 일치 시
                : _confirmPasswordController.text.isNotEmpty
                    ? Icon(Icons.close, color: Colors.red) // 비밀번호 불일치 시
                    : null // 비밀번호 확인 필드가 비어있는 경우 아이콘 표시 안 함
            : null,
      ),
      obscureText: true, // 비밀번호 가리기
      onChanged: isPasswordCheckField ? (_) => setState(() {}) : null, // 비밀번호 확인 필드의 값이 변경될 때마다 상태 업데이트
    );
  }

  void _checkNicknameExistence() {
    // 닉네임 길이 검사
    String nickname = _nicknameController.text;
    if (nickname.length < 1 || nickname.length > 8) {
      // 길이 조건에 맞지 않을 때 경고 창 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Nickname Length"),
            content: Text("The nickname length must be between 1 and 8 characters."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
              ),
            ],
          );
        },
      );
      return; // 여기서 함수 종료
    }
    // 비밀번호와 비밀번호 확인 필드가 일치하는지 확인
    if (_passwordController.text != _confirmPasswordController.text) {
      // 비밀번호 일치하지 않을 때 경고 창 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Password Mismatch"),
            content: Text("Please make sure the passwords match."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
              ),
            ],
          );
        },
      );
      return; // 여기서 함수 종료
    }

    // 비동기 함수 호출로 닉네임 중복 확인
    checkNicknameExistence(_nicknameController.text).then((isExist) {
      if (!isExist) {
        // 닉네임이 중복되지 않음, 사용자에게 확인 요청
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Nickname Available"),
              content: Text("The nickname is available. Do you want to use this nickname?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                ),
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    // 사용자가 닉네임 사용을 확정
                    setState(() {
                      _isNicknameChecked = true;
                      _isPasswordFieldEnabled = false; // 비밀번호 필드 비활성화
                      _isNicknameFieldEnabled = false; // 닉네임 필드 비활성화
                    });
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                ),
              ],
            );
          },
        );
      } else {
        // 닉네임이 중복됨, 사용자에게 알림
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Duplicate Nickname"),
              content: Text("This nickname is already in use. Please enter a different nickname."),
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
      // 오류 처리
      print("An error occurred: $error");
    });
  }
  
  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerVisible = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
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
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel(); // 위젯이 소멸될 때 타이머를 취소
    super.dispose();
  }
}
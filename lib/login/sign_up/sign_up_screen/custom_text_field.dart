import 'package:flutter/material.dart';

class CustomTextFieldWithButton extends StatelessWidget {
  final TextEditingController controller;
  final bool fieldEnabled;
  final String label;
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final bool isEmailVerified;
  final bool isTimerVisible;
  final int remainingTime;
  final bool isNicknameChecked;
  final bool isCertificationNumberVerified;

  const CustomTextFieldWithButton({
    Key? key,
    required this.controller,
    required this.fieldEnabled,
    required this.label,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor = Colors.yellow,
    required this.isEmailVerified,
    required this.isTimerVisible,
    required this.remainingTime,
    required this.isNicknameChecked,
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
          suffixIcon: _buildSuffixIcon(),
          suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    if (isEmailVerified && label == "Email") {
      return _buildCheckIcon();
    } else if (isTimerVisible && label == "Email") {
      return _buildTimerText();
    } else if (label == 'Nickname' && isNicknameChecked) {
      return _buildCheckIcon();
    } else if (label == 'Certification Number' && isCertificationNumberVerified) {
      return _buildCheckIcon();
    } else {
      return ElevatedButton(
        child: Text(buttonText),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: Colors.black,
          textStyle: TextStyle(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
          minimumSize: Size(130, 48),
        ),
        onPressed: onPressed,
      );
    }
  }

  Widget _buildCheckIcon() => SizedBox(
      width: 50,
      child: Icon(Icons.check, color: Colors.green),
  );

  Widget _buildTimerText() => Padding(
      padding: EdgeInsets.all(10),
      child: Text('$remainingTime s', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
  );
}

import 'package:flutter/material.dart';
import 'login/login/login_screen.dart'; // Make sure to create this file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
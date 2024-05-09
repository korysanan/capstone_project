import 'package:flutter/material.dart';
import 'login/login_design_1/myapp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login_Screen(),
      theme: ThemeData(fontFamily: 'Jalnan'),
    );
  }
}
import 'package:capstone_project/home/main_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to K-Food Box!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Image.asset(
              'assets/ex/korea_door.png',
              width: 400,
              height: 400,
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                width: double.infinity, // Set the width as needed
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 229, 115, 114), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius if needed
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding if needed
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('LOGIN'),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                width: double.infinity, // Set the width as needed
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 101, 180, 249), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius if needed
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding if needed
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KFoodBoxHome()),
                    );
                  },
                  child: Text('GUEST MODE'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

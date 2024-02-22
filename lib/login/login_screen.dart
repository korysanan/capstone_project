import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import '../home/main_screen.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'K-Food Box',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 48.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'EMAIL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Log in'),
              onPressed: () {
                print('Login button pressed'); // 로그인 db 구현 했을때 일치 하면 적용되게 설정하기 
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
            TextButton(
              child: Text('Forgot Password?'),
              onPressed: () {
                print('Forgot Password button pressed');
              },
            ),
            TextButton(
              child: Text('Need An account? SIGN UP'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
                // 회원가입 화면으로 이동 
                // lib/login/sign_up_screen.dart로 이동
              },
            ),
            SizedBox(height: 100.0),
            ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8.0),
                  Text(
                    'Guest Mode',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KFoodBoxHome()),
                );
                // lib/home/main_screen.dart로 이동 
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[400],
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

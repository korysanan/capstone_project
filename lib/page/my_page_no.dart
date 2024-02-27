import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../login/sign_up_screen.dart';
import '../login/login_screen.dart';

class MyPageNo extends StatefulWidget {
  @override
  _MyPageNoState createState() => _MyPageNoState();
}

class _MyPageNoState extends State<MyPageNo> {
  int _currentIndex = 0; // bottomnavigation index 번호 

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // 아이콘 눌렀을때 인덱스 번호 설정 
  // home = 0, mail = 1, camera = 2, search = 3 , chatbot = 4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyPage'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              // Handle settings button action
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person_outline, size: 128),
            Text('guest'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      // lib/home/bottom.dart에서 bottomNavigation 불러오기 
    );
  }
}

import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../login/sign_up/sign_up_screen.dart';
import '../login/login_screen.dart';
import 'language_setting.dart';
import '../home/on_item_tap.dart';
import '../globals.dart' as globals;
import '../home/main_screen.dart';

class MyPageNo extends StatefulWidget {
  @override
  _MyPageNoState createState() => _MyPageNoState();
}

class _MyPageNoState extends State<MyPageNo> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KFoodBoxHome()),
            );
          },
        ),
        title: Text(globals.getText('myPageTitle')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguageSelectScreen(
                    onLanguageSelected: (selectedCode) {
                    },
                  ),
                ),
              ).then((_) => setState(() {})); // 언어 선택 후 UI 갱신
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person_outline, size: 128),
            Text(globals.getText('guest')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(globals.getText('login')),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(globals.getText('signUp')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

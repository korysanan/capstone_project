import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/on_item_tap.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 위치 고정하는거 -> 이거 x일시 만약 키보드 올라올때 각각들도 따라 올라옴 
      appBar: AppBar(
        title: Text('User Information'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'E-Mail',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'abcd@gmail.com',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'nickname',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'password',
              ),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'password check',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Submit button action
                },
                child: Text('submit'),
              ),
            ),
            Spacer(), // This will push the withdrawal button to the bottom
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: 20), // 버튼 위에 공간을 추가합니다.
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // 버튼 주위에 padding을 추가합니다.
                decoration: BoxDecoration(
                  color: Colors.white, // 박스 배경색을 지정합니다.
                  border: Border.all(color: Colors.red), // 박스의 테두리색을 지정합니다.
                  borderRadius: BorderRadius.circular(4.0), // 박스의 모서리를 둥글게 합니다.
                ),
                child: TextButton(
                  onPressed: () {
                    // 팝업창을 표시하는 함수를 호출합니다.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Do you really want to withdraw?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('withdraw'),
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('withdrawal'),
                  style: TextButton.styleFrom(
                    primary: Colors.red, // 버튼 텍스트 색상을 지정합니다.
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index), // 수정된 부분
      ),
    );
  }
}
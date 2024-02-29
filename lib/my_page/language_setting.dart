import 'package:flutter/material.dart';
import '../home/bottom.dart';

class LanguageSelectScreen extends StatefulWidget {
  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Map<String, dynamic>> languages = [
    {'name': 'Korean', 'flag': '🇰🇷'},
    {'name': 'English', 'flag': '🇺🇸'},
    {'name': 'Chinese', 'flag': '🇨🇳'},
    {'name': 'German', 'flag': '🇩🇪'},
    {'name': 'Spanish', 'flag': '🇪🇸'},
    {'name': 'Japanese', 'flag': '🇯🇵'},
    {'name': 'Portuguese', 'flag': '🇵🇹'},
    {'name': 'Hindi', 'flag': '🇮🇳'},
    {'name': 'Dutch', 'flag': '🇳🇱'},
    {'name': 'French', 'flag': '🇫🇷'},
    {'name': 'Russian', 'flag': '🇷🇺'},
    {'name': 'Turkish', 'flag': '🇹🇷'},
  ];
  // 리스트 여기 아래에 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 위치 고정하는거 -> 이거 x일시 만약 키보드 올라올때 각각들도 따라 올라옴 
      appBar: AppBar(
        title: Text('Select Language'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          var language = languages[index]['name'];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(languages[index]['flag']),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                language,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                print('Selected language: $language');
              },
              // 일단 어떤거 선택했는지 출력하는거로 했는데 나중에 여기에 선택하면 언어 변경되게 수정 
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

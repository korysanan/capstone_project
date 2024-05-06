import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import '../translate/language_type.dart';
import '../globals.dart' as globals;
import 'my_page_no.dart';
import 'my_page_yes.dart';

class LanguageSelectScreen extends StatefulWidget {
  final Function(String code) onLanguageSelected;

  const LanguageSelectScreen({Key? key, required this.onLanguageSelected}) : super(key: key);

  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> languages = Language.values.map((lang) {
    return {
      "code": lang.name, // 언어 코드 포함
      "name": lang.language,
      if (lang.locale != null) "locale": lang.locale!,
    };
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (globals.sessionId != null){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPageYes()),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPageNo()),
              );
            } // 세션 보유 여부에 따라 mypage가 달라짐
          },
        ),
        title: Text(globals.getText('Select Language')),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          var code = languages[index]['code'];
          return ListTile(
            title: Text(
              languages[index]['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setState(() {
                globals.selectedLanguageCode = code; // 전역 변수 업데이트
              });
              widget.onLanguageSelected(code); // 선택된 언어 코드를 부모 위젯에 전달
            },
          );
        },
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

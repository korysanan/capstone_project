import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import '../translate/language_type.dart';
import '../globals.dart' as globals;

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
      "flag": lang.flag,
      if (lang.locale != null) "locale": lang.locale!,
    };
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          var code = languages[index]['code'];
          return ListTile(
            leading: CircleAvatar(
              child: Text(languages[index]['flag']),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              languages[index]['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // language_setting.dart 내의 ListTile의 onTap 수정
            onTap: () {
              globals.selectedLanguageCode = code; // 전역 변수 업데이트
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
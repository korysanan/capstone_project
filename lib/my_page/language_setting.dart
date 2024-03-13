import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import '../translate/language_type.dart';

class LanguageSelectScreen extends StatefulWidget {
  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  int _currentIndex = 0;

  // Language 열거형 값을 리스트로 변환
  List<Map<String, dynamic>> languages = Language.values.map((lang) {
    return {
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
          var language = languages[index]['name'];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(languages[index]['flag']!),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                language!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                print('Selected language: $language');
              },
            ),
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
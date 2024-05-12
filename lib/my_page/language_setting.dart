import 'package:capstone_project/translate/language_service.dart';
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
  late int _CI;  // _CI를 late로 선언
  int _currentIndex = 0;
  List<Map<String, dynamic>> languages = Language.values.map((lang) {
    return {
      "id": lang.lang_id,
      "code": lang.name, // 열거형의 이름, 예: 'ko', 'en' 등
      "name": lang.getDisplayName(),
      if (lang.locale != null) "locale": lang.locale,
    };
  }).toList();

  @override
  void initState() {
    super.initState();
    // _CI 초기화
    _CI = globals.user_language_id;  // user_language_id가 null이면 기본값으로 1 사용
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (globals.sessionId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPageYes()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPageNo()),
              );
            }
          },
        ),
        title: Text(globals.getText('Select Language')),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          var code = languages[index]['code'];
          var id = languages[index]['id'];
          bool isSelected = _CI == id;  // 현재 선택된 항목 확인
          return ListTile(
            title: Text(
              languages[index]['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            tileColor: isSelected ? Colors.blue[100] : null,  // 현재 선택된 항목에 색상 적용
            onTap: () async {
              // 다이얼로그를 표시하여 사용자가 선택을 확인할 수 있게 함
              bool confirm = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(globals.getText('Language Change')),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,  // 컨텐츠 영역을 최소화
                      crossAxisAlignment: CrossAxisAlignment.start,  // 텍스트를 왼쪽 정렬
                      children: <Widget>[
                        Text(globals.getText('Want to change the language?')),
                        SizedBox(height: 10),
                        Text('${languages.firstWhere((lang) => lang['id'] == _CI)['name']} -> ${languages[index]['name']}'),  // 현재 언어 표시
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(globals.getText('Cancel')),
                        onPressed: () {
                          Navigator.of(context).pop(false);  // 사용자가 취소를 선택하면 false를 반환
                        },
                      ),
                      TextButton(
                        child: Text(globals.getText('Confirm')),
                        onPressed: () {
                          Navigator.of(context).pop(true);  // 사용자가 확인을 선택하면 true를 반환
                        },
                      ),
                    ],
                  );
                },
              ) ?? false;  // showDialog는 null을 반환할 수 있으므로 null일 때 false를 기본값으로 사용
              // 사용자가 확인을 누른 경우에만 언어 설정을 업데이트
              if (confirm) {
                await updateUserLanguage(id);
                setState(() {
                  _CI = id;  // 선택된 id를 _currentIndex로 업데이트
                  globals.selectedLanguageCode = code; // 전역 변수 업데이트
                });
                widget.onLanguageSelected(code); // 선택된 언어 코드를 부모 위젯에 전달
              }
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
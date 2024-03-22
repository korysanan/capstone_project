// main.dart
import 'package:flutter/material.dart';
import 'trans.dart';
import '../globals.dart' as globals;

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final _translator = Translator('7f0cb90f-8897-474f-a7d0-570e0f6a5bd2:fx');
  String _translatedText = '';
  String _targetLanguageCode = ''; // 기본 언어 코드 설정
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _targetLanguageCode = globals.selectedLanguageCode; // 전역 변수 사용
  }

  void _translate() async {
    String sourceText = _textController.text;
    if (sourceText.isNotEmpty) {
      try {
        String translatedText = await _translator.translateText(sourceText, 'en', _targetLanguageCode);
        setState(() {
          _translatedText = translatedText;
        });
      } catch (e) {
        print('Error translating text: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Translator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: 'Enter text to translate'),
          ),
          ElevatedButton(
            onPressed: _translate,
            child: Text('Translate'),
          ),
          Text(_translatedText, style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

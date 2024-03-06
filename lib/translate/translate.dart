import 'package:flutter/material.dart';
import 'package:deepl_dart/deepl_dart.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  Translator translator = Translator(authKey: '7f0cb90f-8897-474f-a7d0-570e0f6a5bd2:fx');
  late TextEditingController _controller;
  late String _translation;
  late Language _selectedLanguage;

  final SizedBox _sizedBox8 = const SizedBox(height: 8);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _selectedLanguage = Language.en;
    _translation = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text to translate',
                ),
              ),
              _sizedBox8,
              DropdownButton<Language>(
                value: _selectedLanguage,
                onChanged: (Language? value) {
                  if (value != null) setState(() => _selectedLanguage = value);
                },
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items: Language.values.map<DropdownMenuItem<Language>>((Language value) {
                  return DropdownMenuItem<Language>(
                    value: value,
                    child: Row(
                      children: [
                        Text(value.language),
                      ],
                    ),
                  );
                }).toList(),
              ),
              _sizedBox8,
              _sizedBox8,
              const Text("Translation:", style: TextStyle(fontSize: 20)),
              _sizedBox8,
              Text(_translation, style: const TextStyle(fontSize: 18)),
              Expanded(child: _sizedBox8),
              ElevatedButton(
                onPressed: () async {
                  if (_controller.text.isEmpty) return;
                  final apiTranslation = await translator.translateTextSingular(
                      _controller.text, _selectedLanguage.locale ?? _selectedLanguage.name);
                  setState(() {
                    _translation = "${apiTranslation.text} - ${_selectedLanguage.language}";
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Translate'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Language {
  bg(language: "Bulgarian", flag: '🇧🇬'),
  da(language: "Danish", flag: '🇩🇰'),
  de(language: "German", flag: '🇩🇪'),
  el(language: "Greek", flag: '🇬🇷'),
  en(language: "English", locale: "en_US", flag: '🇬🇧'),
  es(language: "Spanish", flag: '🇪🇸'),
  et(language: "Estonian", flag: '🇪🇪'),
  fi(language: "Finnish", flag: '🇫🇮'),
  fr(language: "French", flag: '🇫🇷'),
  hu(language: "Hungarian", flag: '🇭🇺'),
  id(language: "Indonesian", flag: '🇮🇩'),
  it(language: "Italian", flag: '🇮🇹'),
  ja(language: "Japanese", flag: '🇯🇵'),
  ko(language: "Korean", flag: '🇰🇷'),
  lt(language: "Lithuanian", flag: '🇱🇹'),
  lv(language: "Latvian", flag: '🇱🇻'),
  nb(language: "Norwegian Bokmal", flag: '🇳🇴'),
  nl(language: "Dutch", flag: '🇳🇱'),
  pl(language: "Polish", flag: '🇵🇱'),
  pt(language: "Portuguese", locale: "pt-PT", flag: '🇵🇹'),
  ro(language: "Romanian", flag: '🇷🇴'),
  sk(language: "Slovak", flag: '🇸🇰'),
  sl(language: "Slovenian", flag: '🇸🇮'),
  sv(language: "Swedish", flag: '🇸🇪'),
  tr(language: "Turkish", flag: '🇹🇷'),
  uk(language: "Ukrainian", flag: '🇺🇦'),
  zh(language: "Chinese", flag: '🇨🇳');

  const Language({
    required this.language,
    this.locale,
    required this.flag,
  });

  final String language;
  final String? locale;
  final String flag;
}

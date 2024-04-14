import 'package:flutter/material.dart';

class Language {
  final int id;
  final String name;

  Language(this.id, this.name);
}

class LanguageList {
  final List<Language> languages;

  LanguageList.fromJson(Map<String, dynamic> json)
      : languages = (json['languages'] as List)
            .map((item) => Language(item['id'], item['name']))
            .toList();
}

Widget buildDropdownField(String selectedLanguageId, Function(String?) onChanged) {
  final languageList = LanguageList.fromJson({
    "languages": [
      {"id": 1, "name": "한국어"},
      {"id": 2, "name": "Ελληνική"},
      {"id": 3, "name": "Nederlands"},
      {"id": 4, "name": "Norge"},
      {"id": 5, "name": "Dansk"},
      {"id": 6, "name": "Deutsch"},
      {"id": 7, "name": "Latviešu"},
      {"id": 8, "name": "Русский"},
      {"id": 9, "name": "Românesc"},
      {"id": 10, "name": "Lietuvių kalba"},
      {"id": 11, "name": "Български"},
      {"id": 12, "name": "Svenska"},
      {"id": 13, "name": "Español"},
      {"id": 14, "name": "Slovensko"},
      {"id": 15, "name": "Slovenski"},
      {"id": 16, "name": "اللغة العربية"},
      {"id": 17, "name": "Eesti"},
      {"id": 18, "name": "English(USA)"},
      {"id": 19, "name": "English(UK)"},
      {"id": 20, "name": "Українська"},
      {"id": 21, "name": "Italiano"},
      {"id": 22, "name": "Bahasa Indonesia"},
      {"id": 23, "name": "日本語"},
      {"id": 24, "name": "中文"},
      {"id": 25, "name": "Česky"},
      {"id": 26, "name": "Türkçe"},
      {"id": 27, "name": "Português"},
      {"id": 28, "name": "Português(Brasil)"},
      {"id": 29, "name": "Polski"},
      {"id": 30, "name": "Français"},
      {"id": 31, "name": "Suomalainen"},
      {"id": 32, "name": "Magyar"}
    ]
  });

  return DropdownButton<String>(
    value: selectedLanguageId,
    onChanged: onChanged,
    items: languageList.languages.map<DropdownMenuItem<String>>((Language language) {
      return DropdownMenuItem<String>(
        value: language.id.toString(),
        child: Text(language.name),
      );
    }).toList(),
  );
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals.dart';

Future<String> translateText(String text) async {
  final url = Uri.parse(
      'https://api-free.deepl.com/v2/translate?auth_key=$apiKey&text=$text&target_lang=$selectedLanguageCode');

  final response = await http.post(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    final translatedText = jsonResponse['translations'][0]['text'];
    return translatedText;
  } else {
    throw Exception('Failed to translate text.');
  }
}

Future<String> translateTextToEnglish(String text) async {
  final url = Uri.parse(
      'https://api-free.deepl.com/v2/translate?auth_key=$apiKey&text=$text&target_lang=en');

  final response = await http.post(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    final translatedText = jsonResponse['translations'][0]['text'];
    return translatedText;
  } else {
    throw Exception('Failed to translate text.');
  }
}

Future<String> translateTextFromGoogle(String text) async {
  final url = Uri.parse(
      'https://translation.googleapis.com/language/translate/v2?target=$selectedLanguageCode&key=$googleTranslateApiKey&q=$text');

  final response = await http.post(url);

  if (response.statusCode == 200) {
    var dataJson = jsonDecode(response.body);
    return dataJson['data']['translations'][0]['translatedText'];
  } else {
    throw Exception('Failed to translate text.');
  }
}

// translate.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class Translator {
  final String apiKey;

  Translator(this.apiKey);

  Future<String> translateText(String text, String sourceLang, String targetLang) async {
    final url = Uri.parse('https://api-free.deepl.com/v2/translate');
    final response = await http.post(url, body: {
      'auth_key': apiKey,
      'text': text,
      'source_lang': sourceLang,
      'target_lang': targetLang,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse['translations'][0]['text'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
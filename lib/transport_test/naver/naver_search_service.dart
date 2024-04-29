import 'package:http/http.dart' as http;
import 'dart:convert';

class NaverSearchService {
  final String baseUrl = 'https://openapi.naver.com/v1/search/local.json';
  final String clientId;
  final String clientSecret;

  NaverSearchService({required this.clientId, required this.clientSecret});

  Future<dynamic> searchLocal({
    required String query,
    int display = 10,
    int start = 1,
    String sort = 'random',
  }) async {
    final uri = Uri.parse('$baseUrl?query=${Uri.encodeComponent(query)}&display=$display&start=$start&sort=$sort');
    final response = await http.get(
      uri,
      headers: {
        'X-Naver-Client-Id': clientId,
        'X-Naver-Client-Secret': clientSecret,
        'Accept': '*/*'
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

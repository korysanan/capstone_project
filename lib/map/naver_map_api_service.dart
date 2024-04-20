import 'dart:convert';
import 'package:http/http.dart' as http;

class NaverMapAPIService {
  final String clientId;
  final String clientSecret;

  NaverMapAPIService(this.clientId, this.clientSecret);

  Future<dynamic> getDrivingDirections(String start, String goal, {String option = 'trafast'}) async {
    final uri = Uri.parse('https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving?start=$start&goal=$goal&option=$option');
    final response = await http.get(
      uri,
      headers: {
        'X-NCP-APIGW-API-KEY-ID': clientId,
        'X-NCP-APIGW-API-KEY': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      var decodedResponse = utf8.decode(response.bodyBytes);  // UTF-8로 디코드
      return jsonDecode(decodedResponse);
    } else {
      throw Exception('Failed to load directions');
    }
  }
}
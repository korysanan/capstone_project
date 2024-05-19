import 'dart:convert';
import '../../service/odsay_api_service.dart'; // JSON 디코딩을 위해 추가

Future<void> s1fetchData(double sx, double sy, double ex, double ey) async {
  String result = await ApiService.fetchBusData(sx, sy, ex, ey);

  // JSON 응답 파싱
  var jsonResult = json.decode(result);

  // 경로가 여러 개인 경우 필터링 조건에 따라 경로를 선택
  if (jsonResult['result']['path'] != null) {
    List<dynamic> paths = jsonResult['result']['path'];

    jsonResult['result']['path'] = paths;
  }

  // JSON 데이터를 파싱하여 변수에 저장
  Map<String, dynamic> jsonMap = jsonDecode(json.encode(jsonResult));
  print(jsonMap);
}
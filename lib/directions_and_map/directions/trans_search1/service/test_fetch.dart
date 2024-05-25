import 'dart:convert';

import 's1_odsay.dart';

Future<void> fetchData(double sx, double sy, double ex, double ey, {int? paymentThreshold, int? timeThreshold, required Function(Map<String, dynamic>) onComplete}) async {
  String result = await ApiService.fetchBusData(sx, sy, ex, ey);

  // JSON 응답 파싱
  var jsonResult = json.decode(result);

  // 경로가 여러 개인 경우 필터링 조건에 따라 경로를 선택
  if (jsonResult['result']['path'] != null) {
    List<dynamic> paths = jsonResult['result']['path'];

    // 첫 번째 조건: 아무런 조건 없이 모든 경로 사용
    if (paymentThreshold == null && timeThreshold == null) {
      // 모든 경로를 사용
    } 
    // 두 번째 조건: totalPayment 기준으로 필터링
    else if (paymentThreshold != null && timeThreshold == null) {
      paths = paths
          .where((path) => path['info'] != null && path['info']['totalPayment'] != null && path['info']['totalPayment'] <= paymentThreshold)
          .toList();
    } 
    // 세 번째 조건: totalTime 기준으로 필터링
    else if (timeThreshold != null && paymentThreshold == null) {
      paths = paths
          .where((path) => path['info'] != null && path['info']['totalTime'] != null && path['info']['totalTime'] <= timeThreshold)
          .toList();
    }

    jsonResult['result']['path'] = paths;
  }

  // JSON 데이터를 파싱하여 변수에 저장
  Map<String, dynamic> jsonMap = jsonDecode(json.encode(jsonResult));
  onComplete(jsonMap);
}

Future<Map<String, dynamic>> fetchCityTransitData(double sx, double sy, double ex, double ey) async {
  String result = await ApiService.fetchBusData(sx, sy, ex, ey);

  // JSON 응답 파싱
  var jsonResult = json.decode(result);

  // JSON 데이터를 파싱하여 변수에 저장
  Map<String, dynamic> jsonMap = jsonDecode(json.encode(jsonResult));
  return jsonMap;
}

import 'dart:convert';
import 'odsay_api_service.dart'; // JSON 디코딩을 위해 추가

Future<void> fetchData(double sx, double sy, double ex, double ey, {int? paymentThreshold, int? timeThreshold, required Function(Map<String, dynamic>) onComplete}) async {
  print(sx);
  print(sy);
  print(ex);
  print(ey);
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

  // JSON 객체에서 searchType 값을 추출합니다.
  /*
  int searchType = jsonMap['result']['searchType'];
  double startX = jsonMap['result']['path'][0]['subPath'][0]['startX'];
  double startY = jsonMap['result']['path'][0]['subPath'][0]['startY'];
  print('searchType: $searchType');
  */
}
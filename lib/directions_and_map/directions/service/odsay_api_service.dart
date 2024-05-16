import 'package:http/http.dart' as http;
import '../../../globals.dart';

class ApiService {
  static Future<String> fetchBusData(double sx, double sy, double ex, double ey) async {
    String url = "https://api.odsay.com/v1/api/searchPubTransPathT?lang=1&SX=$sx&SY=$sy&EX=$ex&EY=$ey&apiKey=" +
        Uri.encodeComponent(ODSay_apiKey);
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return response.body;  // Return the successful response body
      } else {
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      return 'An error occurred: $e';
    }
  }
}
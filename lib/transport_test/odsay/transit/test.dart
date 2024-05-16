import 'package:flutter/material.dart';
import 'fetch.dart';
import 'transit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _result = '버튼을 눌러 데이터를 가져오세요';
  String _result2 = '';

  double sx = 126.6335;
  double sy = 36.19709;
  double ex = 129.1665;
  double ey = 35.19159;
  int? paymentThreshold;
  int? timeThreshold;

  void _navigateToTransitScreen(BuildContext context, Map<String, dynamic> jsonMap) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransitScreen(jsonMap: jsonMap),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API 요청 예제'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Payment Threshold',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  paymentThreshold = int.tryParse(value);
                  timeThreshold = null; // 시간 임계값을 사용하지 않음
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Time Threshold',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  timeThreshold = int.tryParse(value);
                  paymentThreshold = null; // 비용 임계값을 사용하지 않음
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => fetchData(
                  sx, sy, ex, ey,
                  paymentThreshold: paymentThreshold,
                  timeThreshold: timeThreshold,
                  onComplete: (jsonMap) {
                    _navigateToTransitScreen(context, jsonMap);
                  },
                ),
                child: Text('버스 데이터 가져오기'),
              ),
              SizedBox(height: 20),
              Text(
                _result,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                _result2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
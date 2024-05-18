import 'package:flutter/material.dart';
import '../../globals.dart' as globals;
import '../naver_map_api_service.dart';
import 'directions_result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NaverTestScreen(),
    );
  }
}

class NaverTestScreen extends StatefulWidget {
  @override
  _NaverTestScreenState createState() => _NaverTestScreenState();
}

class _NaverTestScreenState extends State<NaverTestScreen> {
  final _naverMapAPIService = NaverMapAPIService('0zwgla6npt', 'i89JWsdVDpyzGEcPBGSmTl774rt0nj9Mj0n19lkD');

  void _getDirections(BuildContext context) async {
    try {
      var directions = await _naverMapAPIService.getDrivingDirections(
        '${globals.my_longitude},${globals.my_latitude}',
        '${globals.arr_longitude},${globals.arr_latitude}'
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DirectionsResultScreen(directions: directions),
        ),
      );
    } catch (e) {
      print('Error getting directions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Naver Map Directions Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _getDirections(context),
          child: Text('Get Directions'),
        ),
      ),
    );
  }
}

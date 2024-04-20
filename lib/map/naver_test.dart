import 'package:flutter/material.dart';
import 'naver_map_api_service.dart';

class NaverTestScreen extends StatefulWidget {
  @override
  _NaverTestScreenState createState() => _NaverTestScreenState();
}

class _NaverTestScreenState extends State<NaverTestScreen> {
  final _naverMapAPIService = NaverMapAPIService('0zwgla6npt', 'i89JWsdVDpyzGEcPBGSmTl774rt0nj9Mj0n19lkD');

  void _getDirections() async {
    try {
      var directions = await _naverMapAPIService.getDrivingDirections(
        '127.1058342,37.359708',
        '129.075986,35.179470'
      );
      print(directions);
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
          onPressed: _getDirections,
          child: Text('Get Directions'),
        ),
      ),
    );
  }
}
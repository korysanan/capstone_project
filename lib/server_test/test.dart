import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String foodInfo = '음식 정보가 여기에 표시됩니다.';

  Future<void> fetchFood(int foodId) async {
    try {
      final response = await http.get(Uri.parse('http://43.201.164.78:8080/foods/$foodId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          foodInfo = data.toString();// 응답 데이터를 문자열로 변환하여 화면에 표시
        });
      } else {
        throw Exception('Failed to load food');
      }
    } catch (e) {
      setState(() {
        foodInfo = '데이터를 가져오는 데 실패했습니다: $e';
      });
    }
  }

  Future<void> fetchFoodCategory(int categoryId) async {
    final response = await http.get(Uri.parse('http://43.201.164.78:8080/food-categories/$categoryId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception('Failed to load food category');
    }
  }

  Future<void> fetchAllFoodCategories() async {
    final response = await http.get(Uri.parse('http://43.201.164.78:8080/food-categories'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      print(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load food categories');
    }
  }

  Future<void> fetchFoodsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('http://43.201.164.78:8080/food-categories/$categoryId/foods'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      print(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load foods for category $categoryId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(foodInfo),
            ElevatedButton(
              onPressed: () => fetchFood(1), // 예시로, ID가 1인 음식 정보를 가져옵니다
              child: Text('음식 정보 가져오기'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:capstone_project/globals.dart';
import 'package:capstone_project/home/main_screen.dart';
//import 'package:capstone_project/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to K-Food Box!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Image.asset(
              'assets/images/korea_door.png',
              width: 400,
              height: 400,
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                width: double.infinity, // Set the width as needed
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 229, 115, 114), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius if needed
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding if needed
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('LOGIN'),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                width: double.infinity, // Set the width as needed
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 101, 180, 249), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius if needed
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding if needed
                  ),
                  onPressed: () async {
                    fetchRecommendedFoods();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KFoodBoxHome()),
                    );
                  },
                  child: Text('GUEST MODE'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchRecommendedFoods() async {
    try {
      var url = Uri.parse('http://api.kfoodbox.click/recommended-foods');
      var response = await http.get(url, headers: {'Accept': '*/*'});

      if (response.statusCode == 200) {
        var decodedResponse = utf8.decode(response.bodyBytes);
        var jsonResponse = json.decode(decodedResponse) as Map<String, dynamic>;
        List<Food> fetchedFoods = [];

        if (jsonResponse.containsKey('foods')) {
          jsonResponse['foods'].forEach((foodJson) {
            fetchedFoods.add(Food.fromJson(foodJson));
          });
        }

        // Update the global foods list
        updateFoods(fetchedFoods);
        print('Foods updated successfully.');
        print(fetchedFoods);
      } else {
        print('Failed to fetch data.');
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

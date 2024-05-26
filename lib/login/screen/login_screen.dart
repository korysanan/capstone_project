import 'dart:convert';

import 'package:capstone_project/login/service/login_service.dart';
//import 'package:capstone_project/login/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:capstone_project/globals.dart';
import 'sign_up_screen/sign_up_email.dart';
import 'package:capstone_project/home/main_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the content takes only needed space
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/kfood_logo.png', height: 400), // Logo Image
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Your email',
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Color(0xFFF1E6FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Your password',
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Color(0xFFF1E6FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 117, 201, 243), // Button color
                  minimumSize: Size(double.infinity, 50), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (_validateEmail(emailController.text)) {
                    LoginService.login(context, emailController.text, passwordController.text);
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Invalid Email'),
                        content: Text('Please enter a valid email address.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('LOGIN'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text(
                  "Don't have an Account ? Sign Up",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 120),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 249, 195, 255),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    await fetchRecommendedFoods();
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchRecommendedFoods() async {
    try {
      var url = Uri.parse('https://api-v2.kfoodbox.click/recommended-foods');
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

        updateFoods(fetchedFoods);
      } else {
        print('Failed to fetch data.');
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  bool _validateEmail(String email) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}

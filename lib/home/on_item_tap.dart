// on_item_tap.dart
import 'package:capstone_project/test/trans_test/text_test.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import '../camera_page/camera_page.dart';
import '../chat_bot/chat.dart';
//import '../map/naver_map.dart';
import '../map/naver_test.dart';


void onItemTapped(BuildContext context, int index) {
  switch (index) {
    case 0: // Home 탭
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KFoodBoxHome()),
      );
      break;
    case 1: // mail 탭
      //initializeAndRunNaverMapApp(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TextTest()),
      );
      break;
    case 2: // Camera 탭
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraPage()),
      );
      break;
    case 3: // search 탭
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NaverTestScreen()),
      );
      break;
    case 4: // chat_bot 탭
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => chatbot()),
      );
      break;
  }
}

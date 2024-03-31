// on_item_tap.dart
import 'package:flutter/material.dart';
import 'main_screen.dart';
import '../camera_page/camera_page.dart';
import '../test/trans_test/text_test.dart';
import '../chat_bot/chat.dart';

void onItemTapped(BuildContext context, int index) {
  switch (index) {
    case 0: // Home 탭
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KFoodBoxHome()),
      );
      break;
    case 1: // mail 탭
      print("mail");
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
      print("search");
      break;
    case 4: // chat_bot 탭
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
      break;
  }
}

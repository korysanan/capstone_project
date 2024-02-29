// on_item_tap.dart
import 'package:flutter/material.dart';
import 'main_screen.dart'; // 여기서는 예시로 main_screen.dart를 import합니다. 실제 경로에 맞게 조정해야 합니다. // KFoodBoxHome 클래스를 import합니다. 실제 경로에 맞게 조정해야 합니다.

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
      break;  
    case 2: // Camera 탭
      print("camera");
      break;
    case 3: // search 탭
      print("search");
      break;
    case 4: // chat_bot 탭
      print("chat_bot");
      break;
  }
}

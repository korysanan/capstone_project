// on_item_tap.dart
import 'package:capstone_project/bookmark/community_bookmark/community_bookmark_service.dart';
import 'package:capstone_project/bookmark/foods_bookmark/foods_bookmark_service.dart';
import 'package:capstone_project/chat_bot/chat.dart';
import 'package:capstone_project/my_page/my_page_no.dart';
import 'package:capstone_project/my_page/my_page_yes.dart';
import 'package:capstone_project/test/trans_test/text_test.dart';
import 'package:flutter/material.dart';
import 'main_page_ex.dart';
import '../../globals.dart' as globals;


Future<void> onItemTapped(BuildContext context, int index) async {
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
        MaterialPageRoute(builder: (context) => chatbot()),
      );
      break;
    case 3: // search 탭
      if (globals.sessionId != null){
        await FoodBookmarkService.fetchBookmarks();
        await CommunityBookmarkService.fetchBookmarks();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyPageYes()),
        );
      }
      else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyPageNo()),
        );
      }
      break;
  }
}

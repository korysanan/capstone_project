import 'package:capstone_project/bookmark/community_bookmark/community_bookmark_service.dart';
import 'package:capstone_project/bookmark/custom-recipe-aricles_bookmark/custom-recipe-articles_bookmark_service.dart';
import 'package:capstone_project/bookmark/foods_bookmark/foods_bookmark_service.dart';
import 'package:capstone_project/chat_bot/chat.dart';
import 'package:capstone_project/my_page/my_page_no.dart';
import 'package:capstone_project/my_page/my_page_service.dart';
import 'package:capstone_project/my_page/my_page_yes.dart';
import 'package:flutter/material.dart';
import '../unifiedSearch/unifiedSearchMain.dart';
import 'main_screen.dart';
import '../globals.dart' as globals;

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
        MaterialPageRoute(builder: (context) => const UnifiedSearchMain()),
      );
      break;
    case 2: // Camera 탭
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const chatbot()),
      );
      break;
    case 3:
      if (globals.sessionId != null) {
        await FoodBookmarkService.fetchBookmarks();
        await CommunityBookmarkService.fetchBookmarks();
        await RecipeBookmarkService.fetchBookmarks();
        await MyPageService.fetchUserArticles();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyPageYes()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyPageNo()),
        );
      }
      break;
  }
}

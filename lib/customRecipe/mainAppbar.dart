import '../home/main_screen.dart';
import 'recipeSearch.dart';
import 'postArticle.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isFromSearch;

  const CommunityAppBar({
    super.key,
    required this.title,
    required this.isFromSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (isFromSearch) {
            Navigator.of(context).pop();
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => KFoodBoxHome()));
          }
        },
        icon: const Icon(Icons.arrow_back),
        iconSize: 40,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RecipeSearch()));
          },
          icon: const Icon(Icons.search),
          iconSize: 40,
        ),
        if (globals.sessionId != null)
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecipePosting()));
            },
            icon: const Icon(Icons.edit),
            iconSize: 40,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

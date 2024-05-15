import 'recipeMain.dart';
import 'package:image_picker/image_picker.dart';
import 'recipeService.dart';
import 'package:flutter/material.dart';

class ReicpeEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  int postId;
  String inputTitle;
  String inputContent;
  List<XFile> images;
  List<String> imageUrls;
  List<Map<String, dynamic>> savedIngredients = [];
  List<Map<String, dynamic>> inputSequence = [];

  ReicpeEditAppBar({
    super.key,
    required this.postId,
    required this.inputTitle,
    required this.inputContent,
    required this.images,
    required this.imageUrls,
    required this.savedIngredients,
    required this.inputSequence,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RecipeMain()));
        },
        icon: const Icon(Icons.arrow_back),
        iconSize: 40,
      ),
      title: const Text(
        'Edit Article',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: TextButton(
            onPressed: () async {
              if (inputTitle != '' && inputContent != '') {
                RecipeSerrvices.editRecipePost(postId, inputTitle, inputContent,
                    images, imageUrls, savedIngredients, inputSequence);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('Post edited!'),
                    );
                  },
                );
                await Future.delayed(const Duration(seconds: 1));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecipeMain()));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Can\'t upload article'),
                          content: const Text(
                              'Article must include title and content'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              }
            },
            child: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

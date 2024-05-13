import 'package:image_picker/image_picker.dart';
import 'recipeMain.dart';
import 'recipeService.dart';
import 'package:flutter/material.dart';

class RecipePostAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  String inputTitle;
  String inputContent;
  List<XFile> images;
  List<Map<String, dynamic>> savedIngredients;
  List<Map<String, dynamic>> inputSequence;

  RecipePostAppBar({
    super.key,
    required this.title,
    required this.inputTitle,
    required this.inputContent,
    required this.images,
    required this.savedIngredients,
    required this.inputSequence,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RecipeMain()));
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: TextButton(
            onPressed: () async {
              if (inputTitle != '' &&
                  inputContent != '' &&
                  savedIngredients.isNotEmpty &&
                  inputSequence.isNotEmpty) {
                RecipeSerrvices.addRecipePost(inputTitle, inputContent, images,
                    savedIngredients, inputSequence);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('Post added!'),
                    );
                  },
                );
                await Future.delayed(const Duration(seconds: 1));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecipeMain()));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Warning'),
                          content: const Text(
                              'Article must include title, content, ingredients and sequence'),
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
              'Post',
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

import 'postInformation.dart';
import '../community/communityMain.dart';
import 'recipeService.dart';
import 'package:flutter/material.dart';

class CommentEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  int postId;
  int commentId;
  String inputContent;

  CommentEditAppBar({
    super.key,
    required this.postId,
    required this.commentId,
    required this.inputContent,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CommuntiyMain()));
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
              if (inputContent != '') {
                RecipeSerrvices.editComment(commentId, inputContent);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('Comment edited!'),
                    );
                  },
                );
                await Future.delayed(const Duration(seconds: 1));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostInformation(
                              postId: postId,
                            )));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Warning'),
                          content: const Text('Comment must include content'),
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

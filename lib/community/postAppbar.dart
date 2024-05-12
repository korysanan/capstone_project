import '../community/communityMain.dart';
import 'package:image_picker/image_picker.dart';
import 'communityService.dart';
import 'package:flutter/material.dart';

class CommunityPostAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  String inputTitle;
  String inputContent;
  List<XFile> images;

  CommunityPostAppBar({
    super.key,
    required this.title,
    required this.inputTitle,
    required this.inputContent,
    required this.images,
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
              if (inputTitle != '' && inputContent != '') {
                CommunitySerrvices.addCommunityPosting(
                    inputTitle, inputContent, images);
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
                        builder: (context) => const CommuntiyMain()));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Warning'),
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

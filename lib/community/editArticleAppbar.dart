import '../community/communityMain.dart';
import 'package:image_picker/image_picker.dart';
import 'communityService.dart';
import 'package:flutter/material.dart';

class CommunityEditAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  int postId;
  String inputTitle;
  String inputContent;
  List<XFile> images;
  List imageUrls;

  CommunityEditAppBar({
    super.key,
    required this.postId,
    required this.inputTitle,
    required this.inputContent,
    required this.images,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CommuntiyMain()));
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
                CommunitySerrvices.editPost(
                    postId, inputTitle, inputContent, images, imageUrls);
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
                    MaterialPageRoute(builder: (context) => CommuntiyMain()));
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

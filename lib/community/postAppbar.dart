import 'communitySearch.dart';
import 'communityService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommunityPostAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  List<XFile?> images = [];

  CommunityPostAppBar({
    super.key,
    required this.title,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
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
            onPressed: () {
              // CommunitySerrvices.postImages(images, 'COMMUNITY_ARTICLE');
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

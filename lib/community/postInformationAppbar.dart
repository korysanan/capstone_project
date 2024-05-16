import 'editArticle.dart';
import 'communityMain.dart';
import 'communityService.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PostInformationAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final int postId;
  final String authorNickname;
  final String userNickname;
  final String title;
  final String content;
  final List imageUrls;
  final bool isChanged;

  const PostInformationAppBar({
    super.key,
    required this.postId,
    required this.authorNickname,
    required this.userNickname,
    required this.title,
    required this.content,
    required this.imageUrls,
    required this.isChanged,
  });

  @override
  State<PostInformationAppBar> createState() => _PostInformationAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PostInformationAppBarState extends State<PostInformationAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          widget.isChanged
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommuntiyMain()))
              : Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
        iconSize: 40,
      ),
      actions: [
        if (widget.authorNickname == widget.userNickname)
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: const Icon(
                Icons.more_vert,
                size: 46,
                color: Colors.black,
              ),
              items: [
                ...MenuItems.items.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
                ),
                const DropdownMenuItem<Divider>(
                    enabled: false, child: Divider()),
              ],
              onChanged: (value) {
                MenuItems.postId = widget.postId;
                MenuItems.title = widget.title;
                MenuItems.content = widget.content;
                MenuItems.imageUrls = widget.imageUrls;
                MenuItems.onChanged(context, value! as MenuItem);
              },
              dropdownStyleData: DropdownStyleData(
                width: 160,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                offset: const Offset(0, 8),
              ),
              menuItemStyleData: MenuItemStyleData(
                customHeights: [
                  ...List<double>.filled(MenuItems.items.length, 48),
                  8,
                ],
                padding: const EdgeInsets.only(left: 16, right: 16),
              ),
            ),
          ),
      ],
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> items = [delete, edit];
  static int postId = -1;
  static String title = '';
  static String content = '';
  static List imageUrls = [];

  static const delete = MenuItem(text: 'Delete', icon: Icons.delete_forever);
  static const edit = MenuItem(text: 'Edit', icon: Icons.edit_document);

  static Future<dynamic> deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                CommunitySerrvices.deletePost(postId);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('Post deleted!'),
                    );
                  },
                );
                await Future.delayed(const Duration(seconds: 1));
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CommuntiyMain()));
              },
              child: const Text('Yes')),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No')),
        ],
      ),
    );
  }

  static Future<dynamic> editDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('Are you sure you want to edit this post?'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog();
                  },
                );
                await Future.delayed(const Duration(seconds: 1));
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommunityArticleEdit(
                              postId: postId,
                              inputTitle: title,
                              inputContent: content,
                              imageUrls: imageUrls,
                            )));
              },
              child: const Text('Yes')),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No')),
        ],
      ),
    );
  }

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.delete:
        deleteDialog(context);
        break;
      case MenuItems.edit:
        editDialog(context);
        break;
    }
  }
}

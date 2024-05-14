import '../translate/language_detect.dart';
import 'editComment.dart';
import 'recipePostInformation.dart';
import 'recipeService.dart';
import '../../globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ArticleComments extends StatefulWidget {
  final int postId;
  List<dynamic>? comments;
  bool isTranslate;
  ArticleComments(
      {required this.postId,
      required this.comments,
      required this.isTranslate,
      super.key});

  @override
  State<ArticleComments> createState() => _ArticleCommentsState();
}

class _ArticleCommentsState extends State<ArticleComments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 2),
        itemCount: widget.comments?.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${widget.comments?[index].nickname}   ',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            RecipeSerrvices.calUploadTime(
                                widget.comments?[index].createdAt),
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xff808080)),
                          ),
                        ],
                      ),
                      widget.isTranslate
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: FutureBuilder<String>(
                                future: translateText(
                                    widget.comments?[index].content),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const Text(
                                        'Error',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        snapshot.data ??
                                            'Translation error', // 번역 실패시 대체 텍스트
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        softWrap: true, // Added this line
                                      );
                                    }
                                  } else {
                                    return const SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              ))
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                widget.comments?[index].content,
                                style: const TextStyle(fontSize: 15),
                                softWrap: true, // Added this line
                              ),
                            ),
                    ],
                  ),
                  if (globals.user_nickname == widget.comments?[index].nickname)
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: const Icon(
                          Icons.more_vert,
                          size: 30,
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
                          MenuItems.commentId = widget.comments?[index].id;
                          MenuItems.content = widget.comments?[index].content;
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
              ),
              const SizedBox(
                width: 500,
                height: 15,
                child: Divider(color: Color(0xff808080), thickness: 1.0),
              ),
            ],
          );
        });
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
  static int commentId = -1;
  static String content = '';

  static const delete = MenuItem(text: 'Delete', icon: Icons.delete_forever);
  static const edit = MenuItem(text: 'Edit', icon: Icons.edit_document);

  static Future<dynamic> deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                RecipeSerrvices.deleteComment(commentId);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('Comment deleted!'),
                    );
                  },
                );
                await Future.delayed(const Duration(seconds: 1));
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RecipeInformation(postId: postId)));
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
        content: const Text('Are you sure you want to edit this comment?'),
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
                        builder: (context) => CommunityCommentEdit(
                              postId: postId,
                              commentId: commentId,
                              inputContent: content,
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

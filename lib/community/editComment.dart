import 'dart:io';
import 'editCommentAppbar.dart';
import 'package:flutter/material.dart';

class CommunityCommentEdit extends StatefulWidget {
  int postId;
  int commentId;
  String inputContent;
  CommunityCommentEdit({
    super.key,
    required this.postId,
    required this.commentId,
    required this.inputContent,
  });

  @override
  State<CommunityCommentEdit> createState() => _CommunityCommentEditState();
}

class _CommunityCommentEditState extends State<CommunityCommentEdit> {
  late final bodyController = TextEditingController(text: widget.inputContent);
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar: CommentEditAppBar(
          postId: widget.postId,
          commentId: widget.commentId,
          inputContent: widget.inputContent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 500,
                child: Divider(color: Colors.black, thickness: 2.0),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your contents',
                ),
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 18,
                ),
                keyboardType: TextInputType.multiline,
                controller: bodyController,
                onChanged: (value) {
                  setState(() => widget.inputContent = value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

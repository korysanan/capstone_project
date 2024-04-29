import 'communityService.dart';
import 'postComment.dart';
import 'postImage.dart';
import '../db/comment.dart';
import '../db/communityPost.dart';
import '../home/appbar.dart';
import 'package:flutter/material.dart';

class PostInformation extends StatefulWidget {
  final int postId;
  const PostInformation({
    super.key,
    required this.postId,
  });

  @override
  State<PostInformation> createState() => _PostInformationState();
}

class _PostInformationState extends State<PostInformation> {
  late int postId;
  CommunityPost post = CommunityPost(
    id: 0,
    userId: 0,
    isMine: false,
    isBookmarked: false,
    like: false,
    title: 'title',
    content: 'content',
    imageUrls: [],
    createdAt: '',
    updatedAt: '',
    nickname: 'nickname',
    likeCount: 12,
    commentCount: 10,
  );
  List<Comment> comments = [];
  String inputText = '';
  final commentController = TextEditingController();
  final focusNode = FocusNode();

  void bookmarkPressed() {}

  void likePressed() {}

  @override
  void initState() {
    super.initState();
    postId = widget.postId;
    CommunitySerrvices.getPostInfo(postId).then((value) {
      setState(() {
        post = value;
      });
    });
    CommunitySerrvices.getComments(postId).then((value) {
      setState(() {
        comments = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(inputText);
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        body: Scaffold(
          appBar: const BasicAppBar(title: ''),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Text(
                          post.likeCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Icon(
                          Icons.mode_comment,
                          color: Colors.blue,
                        ),
                        Text(
                          post.commentCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(post.createdAt.toString())
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 500,
                    child: Divider(color: Colors.black, thickness: 2.0),
                  ),
                  Text(
                    post.content,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (post.imageUrls.isNotEmpty)
                    PostImages(images: post.imageUrls),
                  // const SizedBox(
                  //   width: 500,
                  //   child: Divider(color: Color(0xff808080), thickness: 1.0),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: likePressed,
                        icon: const Icon(Icons.favorite_border),
                        iconSize: 30,
                        tooltip: 'Like',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: bookmarkPressed,
                        icon: const Icon(Icons.bookmark_border),
                        iconSize: 30,
                        tooltip: 'Bookmark',
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 500,
                    child: Divider(color: Colors.black, thickness: 2.0),
                  ),
                  if (comments.isNotEmpty) PostComments(comments: comments),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Write Comment',
              ),
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
              ),
              focusNode: focusNode,
              controller: commentController,
            ),
          ),
        ),
      ),
    );
  }
}

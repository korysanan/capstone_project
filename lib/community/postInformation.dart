import '../translate/language_detect.dart';
import 'postInformationAppbar.dart';
import '../../globals.dart' as globals;
import 'communityService.dart';
import 'postComment.dart';
import 'postImage.dart';
import '../db/comment.dart';
import '../db/communityPost.dart';
import 'package:flutter/material.dart';
import '../bookmark/community_bookmark/community_bookmark_data.dart';
import '../bookmark/community_bookmark/community_bookmark_service.dart';

class PostInformation extends StatefulWidget {
  final int postId;
  final bool isChanged;
  const PostInformation({
    super.key,
    required this.postId,
    required this.isChanged,
  });

  @override
  State<PostInformation> createState() => _PostInformationState();
}

class _PostInformationState extends State<PostInformation> {
  late int postId;
  String title = '';
  String content = '';
  bool isTranslate = false;
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
    likeCount: 0,
    commentCount: 0,
  );
  List<Comment> comments = [];
  final commentController = TextEditingController();
  final focusNode = FocusNode();
  bool bookmarkStatus = false;
  bool likeStatus = false;

  Future<dynamic> commentDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('You must log in to post a comment'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK')),
        ],
      ),
    );
  }

  Future<void> translateArticle() async {
    String translatedTitle = await translateText(title);
    String tanslatedContent = await translateText(content);
    setState(() {
      isTranslate = true;
      title = translatedTitle;
      content = tanslatedContent;
    });
  }

  void fetchInitialBookmarks() async {
    await CommunityBookmarkService.fetchBookmarks();
    setState(() {
      bookmarkStatus = CommunityBookmarkData.isBookmarked(postId);
    });
  }

  void toggleBookmark(int postId) async {
    if (bookmarkStatus) {
      await CommunityBookmarkService.deleteBookmark(postId);
    } else {
      await CommunityBookmarkService.addBookmark(postId);
    }
    setState(() {
      bookmarkStatus = !bookmarkStatus;
    });
  }

  void toggleLike(int postId) async {
    if (likeStatus) {
      await CommunityBookmarkService.deleteLike(postId);
    } else {
      await CommunityBookmarkService.addLike(postId);
    }
    setState(() {
      likeStatus = !likeStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    postId = widget.postId;
    CommunitySerrvices.getPostInfo(postId).then((value) {
      setState(() {
        post = value;
        likeStatus = post.like;
        try {
          title = post.title;
          content = post.content;
        } catch (e) {}
      });
    });
    CommunitySerrvices.getComments(postId).then((value) {
      setState(() {
        comments = value;
      });
    });
    fetchInitialBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        body: Scaffold(
          appBar: PostInformationAppBar(
            postId: post.id,
            authorNickname: post.nickname ?? 'deleted account',
            userNickname: globals.user_nickname ?? '',
            title: post.title,
            content: post.content,
            imageUrls: post.imageUrls,
            isChanged: widget.isChanged,
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Color(0xfff44336),
                      ),
                      Text(
                        post.likeCount.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xfff44336),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.mode_comment,
                        color: Color(0xff475387),
                      ),
                      Text(
                        post.commentCount.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff475387),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          ' |  ${CommunitySerrvices.calUploadTime(post.createdAt)}  | ',
                          style: const TextStyle(
                              color: Color(0xff5b5b5b), fontSize: 12),
                        ),
                      ),
                      Text(
                        post.nickname ?? 'deleted account',
                        style: const TextStyle(
                            color: Color(0xff5b5b5b), fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.g_translate_outlined),
                        label: const Text(
                          'Translate',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: isTranslate
                            ? null
                            : () async {
                                translateArticle();
                              },
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 500,
                    child: Divider(color: Color(0xFF1565C0), thickness: 1.0),
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (post.imageUrls.isNotEmpty)
                    PostImages(images: post.imageUrls),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => toggleLike(postId),
                        icon: likeStatus
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border_outlined),
                        iconSize: 30,
                        tooltip: 'Like',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () => toggleBookmark(postId),
                        icon: bookmarkStatus
                            ? const Icon(Icons.bookmark)
                            : const Icon(Icons.bookmark_border_outlined),
                        iconSize: 30,
                        tooltip: 'Bookmark',
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 500,
                    child: Divider(color: Color(0xFF1565C0), thickness: 1.0),
                  ),
                  if (comments.isNotEmpty)
                    isTranslate
                        ? ArticleComments(
                            postId: post.id,
                            comments: comments,
                            isTranslate: true,
                          )
                        : ArticleComments(
                            postId: post.id,
                            comments: comments,
                            isTranslate: false,
                          )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (globals.sessionId == null) {
                        commentDialog(context);
                      } else {
                        if (commentController.text.isNotEmpty) {
                          CommunitySerrvices.addCommunityComment(
                              post.id, commentController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostInformation(
                                      postId: post.id,
                                      isChanged: true,
                                    )),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

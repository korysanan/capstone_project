import '../bookmark/custom-recipe-aricles_bookmark/custom-recipe-articles_bookmark_data.dart';
import '../bookmark/custom-recipe-aricles_bookmark/custom-recipe-articles_bookmark_service.dart';
import '../db/recipePost.dart';
import '../translate/language_detect.dart';
import 'postInformationAppbar.dart';
import '../../globals.dart' as globals;
import 'recipeService.dart';
import 'postComment.dart';
import 'postImage.dart';
import '../db/comment.dart';
import 'package:flutter/material.dart';

class RecipeInformation extends StatefulWidget {
  final int postId;
  const RecipeInformation({
    super.key,
    required this.postId,
  });

  @override
  State<RecipeInformation> createState() => _RecipeInformationState();
}

class _RecipeInformationState extends State<RecipeInformation> {
  late int postId;
  String title = '';
  String content = '';
  bool isTranslate = false;
  bool isLoading = false;
  RecipePost post = RecipePost(
    id: -1,
    userId: -1,
    isMine: false,
    isBookmarked: false,
    like: false,
    title: '',
    content: '',
    sequences: [],
    ingredients: [],
    imageUrls: [],
    createdAt: '',
    updatedAt: '',
    nickname: '',
    likeCount: -1,
    commentCount: -1,
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
    setState(() {
      isLoading = true;
    });
    String translatedTitle = await translateText(title);
    String tanslatedContent = await translateText(content);

    setState(() {
      isTranslate = true;
      title = translatedTitle;
      content = tanslatedContent;
      isLoading = false;
    });
  }

  void fetchInitialBookmarks() async {
    await RecipeBookmarkService.fetchBookmarks();
    setState(() {
      bookmarkStatus = RecipeBookmarkData.isBookmarked(postId);
    });
  }

  void toggleBookmark(int postId) async {
    if (bookmarkStatus) {
      await RecipeBookmarkService.deleteBookmark(postId);
    } else {
      await RecipeBookmarkService.addBookmark(postId);
    }
    setState(() {
      bookmarkStatus = !bookmarkStatus;
    });
  }

  void toggleLike(int postId) async {
    if (likeStatus) {
      await RecipeBookmarkService.deleteLike(postId);
    } else {
      await RecipeBookmarkService.addLike(postId);
    }
    setState(() {
      likeStatus = !likeStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    postId = widget.postId;
    RecipeSerrvices.getPostInfo(postId).then((value) {
      setState(() {
        post = value;
        try {
          title = post.title;
          content = post.content;
        } catch (e) {}
      });
    });
    RecipeSerrvices.getComments(postId).then((value) {
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
            postId: postId,
            authorNickname: post.nickname ?? 'deleted account',
            userNickname: globals.user_nickname ?? '',
            title: post.title,
            content: post.content,
            imageUrls: post.imageUrls,
            ingredients: post.ingredients,
            sequences: post.sequences,
          ),
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Translating...',
                            style: TextStyle(fontSize: 20)),
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Center(
                              child:
                                  Image.asset('assets/images/load-33_256.gif')),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
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
                                ' |  ${RecipeSerrvices.calUploadTime(post.createdAt)}  | ',
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
                          child:
                              Divider(color: Color(0xFF1565C0), thickness: 1.0),
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
                        if (post.ingredients.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  globals.getText('Ingredients and portions'),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: post.ingredients.reversed.map((ingredient) {
                            return Column(children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (isTranslate)
                                      FutureBuilder<String>(
                                        future: translateTextFromGoogle(
                                            '${ingredient['name']}'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasError) {
                                              return const Text(
                                                'Error',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                ),
                                              );
                                            } else {
                                              return Text(
                                                snapshot.data ??
                                                    'Translation error', // 번역 실패시 대체 텍스트
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              );
                                            }
                                          } else {
                                            return const SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    else
                                      Text('${ingredient['name']}'),
                                    if (isTranslate)
                                      FutureBuilder<String>(
                                        future: translateTextFromGoogle(
                                            '${ingredient['quantity'] ?? ''}'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasError) {
                                              return const Text(
                                                'Error',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                ),
                                              );
                                            } else {
                                              return Text(
                                                snapshot.data ??
                                                    'Translation error', // 번역 실패시 대체 텍스트
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              );
                                            }
                                          } else {
                                            return const SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    else
                                      Text('${ingredient['quantity'] ?? ''}'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                        if (post.sequences.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  globals.getText('Sequence'),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: post.sequences.map((sequence) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    sequence['sequenceNumber']
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                if (isTranslate)
                                                  FutureBuilder<String>(
                                                    future: translateText(
                                                        '${sequence['content']}'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                            'Error',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 16,
                                                            ),
                                                          );
                                                        } else {
                                                          return Text(
                                                            snapshot.data ??
                                                                'Translation error', // 번역 실패시 대체 텍스트
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        return const SizedBox(
                                                          height: 10,
                                                          width: 10,
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  )
                                                else
                                                  Text(
                                                    sequence['content'],
                                                    softWrap: true,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          if (sequence['imageUrl'] != null)
                                            Image.network(sequence['imageUrl'],
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25),
                                        ]),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: const Divider(
                                        color: Colors.grey,
                                        thickness: 1.0,
                                      ),
                                    ),
                                  ],
                                ));
                          }).toList(),
                        ),
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
                          child: Divider(color: Color(0xFF1565C0)),
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
                          RecipeSerrvices.addCommunityComment(
                              post.id, commentController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecipeInformation(postId: post.id)),
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

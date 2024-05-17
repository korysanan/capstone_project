import 'recipeService.dart';
import '../home/appbar.dart';
import 'package:flutter/material.dart';
import 'recipePostInformation.dart';
import '../globals.dart' as globals;

class RecipeSearch extends StatefulWidget {
  const RecipeSearch({super.key});

  @override
  State<RecipeSearch> createState() => CommunitySearch();
}

class CommunitySearch extends State<RecipeSearch> {
  String inputText = '';
  final focusNode = FocusNode();
  int page = 1;
  final limit = 20;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List postList = [];
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(nextLoad);
  }

  void initLoad() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    RecipeSerrvices.getArticleList(page, limit, 'ALL', 'LATEST', inputText)
        .then((value) {
      setState(() {
        postList = value;
      });
    });
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  void nextLoad() async {
    if (hasNextPage &&
        !isFirstLoadRunning &&
        !isLoadMoreRunning &&
        controller.position.extentAfter < 100) {
      setState(() {
        isLoadMoreRunning = true;
      });
      page += 1;

      RecipeSerrvices.getArticleList(
              page, limit, 'ALL', 'LATEST', widget.hashCode)
          .then((value) {
        if (value.isNotEmpty) {
          setState(() {
            postList.addAll(value);
          });
        } else {
          setState(() {
            hasNextPage = false;
          });
        }
      });

      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(nextLoad);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar: const BasicAppBar(title: 'Community Search'),
        body: isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SearchBar(
                      focusNode: focusNode,
                      trailing: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            initLoad();
                            page = 1;
                          },
                        ),
                      ],
                      backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 202, 209, 249),
                      ),
                      shadowColor: const MaterialStatePropertyAll(Colors.black),
                      overlayColor:
                          const MaterialStatePropertyAll(Color(0xFFAEB9F0)),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 20,
                        minHeight: 55.0,
                      ),
                      shape: MaterialStateProperty.all(
                        ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(5)),
                      hintText: globals.getText("Enter a search term"),
                      onChanged: (value) {
                        setState(
                            () => inputText = value); // 입력값 inputText로 실시간 저장
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: postList.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          title: Text(
                            postList[index].title,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postList[index].content,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Color(0xfff44336),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      postList[index].likeCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xfff44336),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.mode_comment,
                                    color: Color(0xff475387),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      postList[index].commentCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff475387),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      '  |   ${RecipeSerrvices.calUploadTime(postList[index].createdAt)}   |  ',
                                      style: const TextStyle(
                                          color: Color(0xff5b5b5b),
                                          fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    postList[index].nickname ??
                                        'deleted account',
                                    style: const TextStyle(
                                        color: Color(0xff5b5b5b), fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipeInformation(
                                          postId: postList[index].id,
                                          isChanged: false,
                                        )));
                          },
                        ),
                      ),
                    ),
                  ),
                  if (isLoadMoreRunning == true)
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

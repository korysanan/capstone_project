import 'recipePostInformation.dart';
import 'package:flutter/cupertino.dart';
import 'mainAppbar.dart';
import '../home/bottom.dart';
import 'package:flutter/material.dart';
import '../home/on_item_tap.dart';
import 'recipeService.dart';
import '../globals.dart' as globals;

const List<String> list = <String>['LATEST', 'OLDEST', 'LIKES', 'COMMENTS'];

class RecipeMain extends StatefulWidget {
  String? inputText;
  RecipeMain({
    this.inputText,
    super.key,
  });

  @override
  State<RecipeMain> createState() => _RecipeMainState();
}

class _RecipeMainState extends State<RecipeMain> {
  int idx = 0;
  String type = "ALL";
  String sort = "LATEST";
  String dropdownValue = list.first;
  final int _currentIndex = 0; // bottomnavigation index 번호
  int page = 1;
  final limit = 10;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List postList = [];
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    initLoad();
    controller = ScrollController()..addListener(nextLoad);
  }

  void initLoad() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    RecipeSerrvices.getArticleList(page, limit, type, sort, widget.inputText)
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

      RecipeSerrvices.getArticleList(page, limit, type, sort, null)
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
    return Scaffold(
      appBar: CommunityAppBar(
        title: globals.getText('custom recipes'),
        isFromSearch: widget.inputText != null,
      ),
      body: isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          elevation: 16,
                          style: const TextStyle(color: Color(0xFF1565C0)),
                          underline: Container(
                            height: 2,
                            color: const Color(0xFF1565C0),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                              sort = value;
                              page = 1;
                              hasNextPage = true;
                              isLoadMoreRunning = false;
                              initLoad();
                              controller = ScrollController()
                                ..addListener(nextLoad);
                            });
                          },
                          items: list.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: postList.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    postList[index].commentCount.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff475387),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    '  |   ${RecipeSerrvices.calUploadTime(postList[index].createdAt)}   |  ',
                                    style: const TextStyle(
                                        color: Color(0xff5b5b5b), fontSize: 12),
                                  ),
                                ),
                                Text(
                                  postList[index].nickname ?? 'deleted account',
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
                                      postId: postList[index].id)));
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
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

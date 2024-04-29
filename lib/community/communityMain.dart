import 'mainAppbar.dart';
import '../home/bottom.dart';
import 'package:flutter/material.dart';

enum Article { all, hot, notice }

const List<String> list = <String>['Latest', 'Oldest', 'Likes', 'Comments'];

class CommuntiyMain extends StatefulWidget {
  const CommuntiyMain({super.key});

  @override
  State<CommuntiyMain> createState() => _CommuntiyMainState();
}

class _CommuntiyMainState extends State<CommuntiyMain> {
  Article articleView = Article.all;
  String dropdownValue = list.first;
  int _currentIndex = 0; // bottomnavigation index 번호

  final url = 'http://api.kfoodbox.click';
  int page = 1;
  final limit = 15;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List postList = [];
  late ScrollController controller;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommunityAppBar(title: 'Community'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SegmentedButton<Article>(
                    segments: const <ButtonSegment<Article>>[
                      ButtonSegment<Article>(
                          value: Article.all,
                          label: Text('All'),
                          icon: Icon(Icons.article_outlined)),
                      ButtonSegment<Article>(
                          value: Article.hot,
                          label: Text('Hot'),
                          icon: Icon(Icons.favorite)),
                      ButtonSegment<Article>(
                          value: Article.notice,
                          label: Text('Notice'),
                          icon: Icon(Icons.notifications)),
                    ],
                    selected: <Article>{articleView},
                    onSelectionChanged: (Set<Article> newSelection) {
                      setState(
                        () {
                          articleView = newSelection.first;
                        },
                      );
                    },
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
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
              ],
            ),
          ),
          // ListView.builder(
          //     itemCount: 100,
          //     itemBuilder: (BuildContext ctx, int idx) {
          //       return Text('Content Number $idx');
          //     })
          // 게시판 리스트
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

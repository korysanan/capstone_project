import 'package:capstone_project/unifiedSearch/unifiedSearchService.dart';
import '../categoryPage/foodInformation.dart';
import '../home/appbar.dart';
import '../home/bottom.dart';
import 'package:flutter/material.dart';
import '../home/on_item_tap.dart';
import '../globals.dart' as globals;

class SearchedFoodList extends StatefulWidget {
  String? inputText;
  SearchedFoodList({
    this.inputText,
    super.key,
  });

  @override
  State<SearchedFoodList> createState() => _SearchedFoodListState();
}

class _SearchedFoodListState extends State<SearchedFoodList> {
  final int _currentIndex = 0; // bottomnavigation index 번호
  int page = 1;
  final limit = 10;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List receivedInfo = [false];
  List foodInfo = [];
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
    UnifiedSearchService.getFoodInfo(page, limit, widget.inputText)
        .then((value) {
      setState(() {
        receivedInfo = value;
        foodInfo.addAll(receivedInfo[2]);
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

      UnifiedSearchService.getFoodInfo(page, limit, widget.inputText)
          .then((value) {
        if (value.isNotEmpty) {
          setState(() {
            foodInfo.addAll(value[2]);
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
      appBar: BasicAppBar(title: globals.getText('foods')),
      body: isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                if (receivedInfo[0])
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: foodInfo.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            foodInfo[index].name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(foodInfo[index].englishName),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodInformation(
                                        foodId: foodInfo[index].id)));
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

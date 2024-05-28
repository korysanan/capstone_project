import 'categoryService.dart';
import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/appbar.dart';
import '../db/foodcategory.dart';
import '../home/on_item_tap.dart';
import '../translate/language_detect.dart';
import 'categoryDetail.dart';
import '../globals.dart' as globals;

class CategoryMain extends StatefulWidget {
  const CategoryMain({super.key});

  @override
  State<CategoryMain> createState() => _CategoryMainState();
}

class _CategoryMainState extends State<CategoryMain> {
  int _currentIndex = 0; // bottomnavigation index 번호
  String inputText = '';
  List<FoodCategory> foodCategories = <FoodCategory>[];
  bool isLoading = true;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void textChanged(String text) {
    inputText = text;
  }

  @override
  void initState() {
    super.initState();
    CategorySerrvices.getCategories().then((value) {
      setState(() {
        foodCategories = value;
      });
    });
  }

  Future<void> translateCategoryName() async {
    for (var category in foodCategories) {
      category.name = await translateText(category.englishName);
    }
    isLoading = false;
  }

  List<Widget> makeCircleImages(foodcategories, context) {
    List<Widget> results = [];
    if (globals.selectedLanguageCode != 'ko') {
      translateCategoryName();
    }
    for (var i = 0; i < foodcategories!.length; i++) {
      if (foodcategories[i].name.contains(inputText)) {
        results.add(
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryDetail(
                          categoryId: i + 1,
                        )),
              );
            }, // 해당 카테고리 페이지로 이동
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(foodcategories[i].imageUrl),
                  radius: 48,
                ),
                globals.selectedLanguageCode == 'ko'
                    ? Text(foodCategories[i].name)
                    : FutureBuilder<String>(
                        future: translateText(foodcategories[i].englishName),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text(
                                'Error',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return Text(
                                snapshot.data ??
                                    'Translation error', // 번역 실패시 대체 텍스트
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
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
                      ),
              ],
            ),
          ),
        );
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: globals.getText('Food Category')),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                children: makeCircleImages(foodCategories, context),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

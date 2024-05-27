import '../translate/language_detect.dart';
import 'categoryDetail.dart';
import '../db/foodcategory.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class CategoryList extends StatelessWidget {
  final List<FoodCategory> foodCategories;
  final String searchText;
  bool isLoading = true;

  CategoryList(
      {super.key, required this.foodCategories, required this.searchText});

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
      if (foodcategories[i].name.contains(searchText)) {
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
                const SizedBox(
                  height: 5,
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
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        35;
    return SizedBox(
      width: sizeX,
      height: sizeY,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        children: makeCircleImages(foodCategories, context),
      ),
    );
  }
}

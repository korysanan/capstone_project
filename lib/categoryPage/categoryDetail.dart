import 'categoryAppbar.dart';
import 'categoryService.dart';
import '../db/categoryFood.dart';
import '../db/categoryInfo.dart';
import 'package:flutter/material.dart';
import 'foodList.dart';
import '../translate/language_detect.dart';
import '../globals.dart' as globals;

class CategoryDetail extends StatefulWidget {
  final int categoryId;
  const CategoryDetail({
    super.key,
    required this.categoryId,
  });

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  late int categoryId;
  String inputText = '';

  FoodCategoryInfo categoryInfo =
      FoodCategoryInfo(id: 0, name: '', englishName: '', explanation: '');
  List<CategoryFood> categoryFoods = [];

  @override
  void initState() {
    super.initState();
    categoryId = widget.categoryId;
    CategorySerrvices.getCategoryInfo(categoryId).then((value) {
      setState(() {
        categoryInfo = value;
      });
    });
    CategorySerrvices.getCategoryFoods(categoryId).then((value) {
      setState(() {
        categoryFoods = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryAppBar(
          title: globals.selectedLanguageCode == 'ko'
              ? categoryInfo.name
              : categoryInfo.englishName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: globals.selectedLanguageCode == 'ko'
                      ? Text(
                          categoryInfo.explanation,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : FutureBuilder<String>(
                          future: translateText(categoryInfo.explanation),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text(
                                  'Error',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              } else {
                                return Text(
                                  snapshot.data ??
                                      'Translation error', // 번역 실패시 대체 텍스트
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
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
                ),
                const SizedBox(
                  width: 500,
                  child: Divider(color: Color(0xFF1565C0), thickness: 1.0),
                ),
                const SizedBox(
                  height: 8,
                ),
                FoodList(
                  foods: categoryFoods,
                  searchText: inputText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

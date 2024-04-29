import 'categoryService.dart';
import '../db/categoryFood.dart';
import '../db/categoryInfo.dart';
import 'package:flutter/material.dart';
import '../home/appbar.dart';
import 'foodList.dart';

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
      FoodCategoryInfo(id: 0, name: '', explanation: '');
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
      appBar: BasicAppBar(title: categoryInfo.name),
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
                  child: Text(
                    categoryInfo.explanation,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 500,
                  child: Divider(color: Colors.black, thickness: 2.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: SearchBar(
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); // 검색 아이콘 누르면 키보드 숨김
                        },
                      ),
                    ],
                    backgroundColor: const MaterialStatePropertyAll(
                      Color(0xFFC9C9C9),
                    ),
                    shadowColor: const MaterialStatePropertyAll(Colors.black),
                    overlayColor:
                        const MaterialStatePropertyAll(Color(0xFFAAAAAA)),
                    constraints: const BoxConstraints(
                      maxWidth: 350.0,
                      minHeight: 55.0,
                    ),
                    shape: MaterialStateProperty.all(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                    hintText: "Enter a category name",
                    onChanged: (value) {
                      setState(
                          () => inputText = value); // 입력값 inputText로 실시간 저장
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                FoodList(
                  foods: categoryFoods,
                  category: 'as',
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

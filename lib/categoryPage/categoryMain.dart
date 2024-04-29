import 'categoryService.dart';
import 'categoryList.dart';
import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/appbar.dart';
import '../db/foodcategory.dart';

class CategoryMain extends StatefulWidget {
  const CategoryMain({super.key});

  @override
  State<CategoryMain> createState() => _CategoryMainState();
}

class _CategoryMainState extends State<CategoryMain> {
  int _currentIndex = 0; // bottomnavigation index 번호
  String inputText = '';
  List<FoodCategory> foodCategories = <FoodCategory>[];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  // 아이콘 눌렀을때 인덱스 번호 설정
  // home = 0, mail = 1, camera = 2, search = 3 , chatbot = 4

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: '음식 카테고리'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
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
                      const MaterialStatePropertyAll(Color(0XFFAAAAAA)),
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
                  hintText: "검색어를 입력하세요",
                  onChanged: (value) {
                    setState(() => inputText = value); // 입력값 inputText로 실시간 저장
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CategoryList(
                foodCategories: foodCategories,
                searchText: inputText,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

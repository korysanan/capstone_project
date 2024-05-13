import 'categoryService.dart';
import 'categoryList.dart';
import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/appbar.dart';
import '../db/foodcategory.dart';
import '../home/on_item_tap.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: globals.getText('Food Category')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
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
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

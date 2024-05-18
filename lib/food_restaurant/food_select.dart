import 'package:flutter/material.dart';

import '../home/bottom.dart';
import '../home/main_screen.dart';
import '../home/on_item_tap.dart';
import 'food_restaurant_db/restaurant_category_db.dart';
import 'region_select.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FoodSelectScreen(),
// This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
      theme: FlexThemeData.light(
        fontFamily: 'Jalnan',
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useFlutterDefaults: true,
          inputDecoratorIsFilled: false,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          navigationBarLabelBehavior:
              NavigationDestinationLabelBehavior.alwaysHide,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
    );
  }
}

// ignore: must_be_immutable
class FoodSelectScreen extends StatelessWidget {
  final int _currentIndex = 0;

  const FoodSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KFoodBoxHome()),
            );
          },
        ),
        title: const Text('Select Korean Food (1/2)'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 4,
        ),
        itemCount: KoreanFood.foods.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _showConfirmationDialog(context, KoreanFood.foods[index].id,
                  KoreanFood.foods[index].name);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.network('http://${KoreanFood.foods[index].imageUrl}',
                        fit: BoxFit.cover, width: 70, height: 70),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            KoreanFood.foods[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            KoreanFood.foods[index].englishName,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, int id, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Selection'),
          content: Text('You have selected $name.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫고
                Navigator.push(
                  // 새 페이지로 이동
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegionSelectScreen(
                            food_id: id,
                            food_name: name,
                          )),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

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
      home: FoodSelectScreen(),
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
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KFoodBoxHome()),
            );
          },
        ),
        title: Text('Select Korean Food (1/2)'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2,
        ),
        itemCount: KoreanFood.foods.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _showConfirmationDialog(context, KoreanFood.foods[index].id, KoreanFood.foods[index].name);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    KoreanFood.foods[index].name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
          title: Text('Confirm Selection'),
          content: Text('You have selected $name.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫고
                Navigator.push( // 새 페이지로 이동
                  context,
                  MaterialPageRoute(builder: (context) => RegionSelectScreen(food_id : id, food_name: name,)),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

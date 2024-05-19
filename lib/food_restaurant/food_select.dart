import 'package:flutter/material.dart';

import '../home/bottom.dart';
import '../home/main_screen.dart';
import '../home/on_item_tap.dart';
import '../translate/language_detect.dart';
import 'food_restaurant_db/restaurant_category_db.dart';
import 'region_select.dart';
import '../globals.dart' as globals;

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
        title: Text(globals.getText('Select Korean Food (1/2)')),
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
            onTap: () async {
              String foodName;

              if (globals.selectedLanguageCode == 'ko') {
                foodName = KoreanFood.foods[index].name;
              } else if (globals.selectedLanguageCode == 'en') {
                foodName = KoreanFood.foods[index].englishName;
              } else {
                // Show a loading dialog while the translation is in progress
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  },
                );

                // Perform the translation
                try {
                  foodName = await translateText(KoreanFood.foods[index].englishName);
                } catch (e) {
                  foodName = 'Error'; // Handle error case
                }

                // Close the loading dialog
                Navigator.of(context, rootNavigator: true).pop();
              }

              _showConfirmationDialog(context, KoreanFood.foods[index].id, foodName);
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
                          child: globals.selectedLanguageCode == 'ko' || globals.selectedLanguageCode == 'en'
                            ? Text(
                                KoreanFood.foods[index].englishName,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                softWrap: true,
                              )
                            : FutureBuilder<String>(
                                future: translateText(KoreanFood.foods[index].englishName), // Assuming translateText is an async function you've defined or imported
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 5),
                                      ],
                                    );
                                  } else if (snapshot.connectionState == ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Error',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        softWrap: true,
                                      );
                                    } else if (snapshot.data != null) {
                                      return Text(
                                        snapshot.data!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        softWrap: true,
                                      );
                                    } else {
                                      return Text(
                                        'No translation available',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        softWrap: true,
                                      );
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
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
          title: Text(globals.getText('Confirm Selection')),
            content: RichText(
              text: TextSpan(
                text: globals.getText('Food of Choice :'),
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          actions: <Widget>[
            TextButton(
              child: Text(globals.getText('Cancel')),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text(globals.getText('Confirm')),
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
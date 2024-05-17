import '../db/categoryFood.dart';
import 'foodInformation.dart';
import 'package:flutter/material.dart';
import '../translate/language_detect.dart';
import '../globals.dart' as globals;

class FoodList extends StatelessWidget {
  final List<CategoryFood> foods;
  final String searchText;
  bool isLoading = true;

  FoodList({
    super.key,
    required this.foods,
    required this.searchText,
  });

  Future<void> translateFoodName() async {
    for (var food in foods) {
      food.name = await translateText(food.englishName);
    }
    isLoading = false;
  }

  List<Widget> makeFoodList(List<CategoryFood> foods, context) {
    List<Widget> results = [];
    if (globals.selectedLanguageCode != 'ko') {
      translateFoodName();
    }
    for (var i = 0; i < foods.length; i++) {
      if (foods[i].name.contains(searchText)) {
        results.add(
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FoodInformation(
                          foodId: foods[i].id,
                        )),
              );
            }, // 해당 음식정보 페이지로 이동
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Container(
                width: 500,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: const Color.fromARGB(255, 199, 206, 240),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              foods[i].name,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            globals.selectedLanguageCode == 'ko'
                                ? Text(foods[i].englishName)
                                : FutureBuilder<String>(
                                    future: translateText(foods[i].englishName),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                            'Error',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            snapshot.data ??
                                                'Translation error', // 번역 실패시 대체 텍스트
                                            style: const TextStyle(
                                              fontSize: 15,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //     AssetImage('assets/image/${foods[i].imageUrl}'),
                // child: Transform.translate(
                //     offset: const Offset(0, 55),
                //     child: Text(foods[i].category)),
              ),
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
    final sizeY = MediaQuery.of(context).size.height * 0.7;
    return SizedBox(
      width: sizeX,
      height: sizeY,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: makeFoodList(foods, context),
      ),
    );
  }
}

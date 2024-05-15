import 'categoryAppbar.dart';
import 'categoryService.dart';
import '../db/food.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../translate/language_detect.dart';
import '../bookmark/foods_bookmark/foods_bookmark_service.dart';
import '../bookmark/foods_bookmark/foods_bookmark_data.dart';
import '../globals.dart' as globals;

class FoodInformation extends StatefulWidget {
  final int foodId;
  const FoodInformation({super.key, required this.foodId});

  @override
  State<FoodInformation> createState() => _FoodInformationState();
}

class _FoodInformationState extends State<FoodInformation> {
  late int foodId;

  Food food = Food(
    id: 0,
    name: '',
    englishName: '',
    imageUrls: [],
    explanation: '',
    englishExplanation: '',
    explanationSource: '',
    recipeSource: '',
    recipeIngredients: [],
    recipeSequence: [],
  );

  bool bookmarkStatus = false;
  void fetchInitialBookmarks() async {
    await FoodBookmarkService.fetchBookmarks();
    setState(() {
      bookmarkStatus = FoodBookmarkData.isBookmarked(foodId);
    });
  }

  void toggleBookmark(int foodId) async {
    if (bookmarkStatus) {
      await FoodBookmarkService.deleteBookmark(foodId);
    } else {
      await FoodBookmarkService.addBookmark(foodId);
    }
    setState(() {
      bookmarkStatus = !bookmarkStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    foodId = widget.foodId;
    CategorySerrvices.getFoodInfo(foodId).then((value) {
      setState(() {
        food = value;
      });
    });
    fetchInitialBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryAppBar(
          title: globals.selectedLanguageCode == 'ko'
              ? food.name
              : food.englishName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: food.imageUrls // imageUrls 리스트
                    .map((imgUrl) => ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                'http://$imgUrl', // 여기서 `!`를 사용하여 `e['url']`이 null이 아님을 단언/ 안하면 오류 발생
                                width: 1050.0,
                                height: 350.0,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(
                width: 500,
                child: Divider(color: Color(0xFF1565C0), thickness: 1.0),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          globals.getText('About'),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: bookmarkStatus
                              ? const Icon(Icons.bookmark)
                              : const Icon(Icons.bookmark_border_outlined),
                          onPressed: () => toggleBookmark(foodId),
                          iconSize: 40,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: globals.selectedLanguageCode == 'ko'
                        ? Text(
                            food.explanation,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : FutureBuilder<String>(
                            future: translateText(food.englishExplanation),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text(
                                    'Error',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data ??
                                        'Translation error', // 번역 실패시 대체 텍스트
                                    style: const TextStyle(
                                      fontSize: 18,
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
                  )
                ],
              ),
              const SizedBox(
                width: 500,
                child: Divider(color: Color(0xFF1565C0), thickness: 1.0),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          globals.getText('Recipe'),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          globals.getText('Ingredients and portions'),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: food.recipeIngredients.reversed.map((ingredient) {
                      return Column(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<String>(
                                future: translateTextFromGoogle(
                                    '${ingredient['name']}'),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const Text(
                                        'Error',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        snapshot.data ??
                                            'Translation error', // 번역 실패시 대체 텍스트
                                        style: const TextStyle(
                                          fontSize: 16,
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
                              FutureBuilder<String>(
                                future: translateTextFromGoogle(
                                    '${ingredient['quantity'] ?? ''}'),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const Text(
                                        'Error',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        snapshot.data ??
                                            'Translation error', // 번역 실패시 대체 텍스트
                                        style: const TextStyle(
                                          fontSize: 16,
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          globals.getText('Sequence'),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: food.recipeSequence.map((sequence) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sequence['sequenceNumber'].toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            FutureBuilder<String>(
                              future: translateText('${sequence['content']}'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return const Text(
                                      'Error',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      snapshot.data ??
                                          'Translation error', // 번역 실패시 대체 텍스트
                                      style: const TextStyle(
                                        fontSize: 16,
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
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (food.explanationSource != null)
                        Text(
                          "Explanation source: ${food.explanationSource}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      if (food.recipeSource != null)
                        Text(
                          "Recipe source: ${food.recipeSource}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

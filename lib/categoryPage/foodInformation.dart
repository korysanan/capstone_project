import 'categoryService.dart';
import '../db/food.dart';
import '../home/appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    foodId = widget.foodId;
    CategorySerrvices.getFoodInfo(foodId).then((value) {
      setState(() {
        food = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: food.name),
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
                                imgUrl!, // 여기서 `!`를 사용하여 `e['url']`이 null이 아님을 단언/ 안하면 오류 발생
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
                child: Divider(color: Colors.black, thickness: 2.0),
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
                        const Text(
                          "About",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          // 북마크 기능 추가
                          onPressed: () {},
                          icon: true
                              ? const Icon(Icons.bookmark_outlined)
                              : const Icon(Icons.bookmark_outline_rounded),
                          iconSize: 40,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 30,
                    ),
                    child: Text(
                      food.explanation,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 500,
                child: Divider(color: Colors.black, thickness: 2.0),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recipe",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ingredients and portions",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 재료 추가
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sequence",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 5,
                  //     horizontal: 30,
                  //   ),
                  //   child: ListView.builder(
                  //     itemCount: food.recipeSequence.length,
                  //     itemBuilder: (BuildContext context, index) {
                  //       return SizedBox(
                  //           height: 50,
                  //           child: Text(
                  //               food.recipeSequence[index]['sequenceNum']));
                  //     },
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        label: const Text(
                          "Custom Recipe",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Explanation source: ${food.explanationSource}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Recipe source: ${food.recipeSource}",
                        style: const TextStyle(
                          fontSize: 15,
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

import 'package:capstone_project/community/communityMain.dart';
import 'package:capstone_project/customRecipe/recipeMain.dart';
import 'package:capstone_project/home/bottom.dart';
import 'package:capstone_project/unifiedSearch/searchedFoodList.dart';
import '../categoryPage/foodInformation.dart';
import '../community/postInformation.dart';
import '../customRecipe/recipePostInformation.dart';
import '../home/on_item_tap.dart';
import 'unifiedSearchService.dart';
import '../home/appbar.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class UnifiedSearchMain extends StatefulWidget {
  const UnifiedSearchMain({super.key});

  @override
  State<UnifiedSearchMain> createState() => _CommunitySearchState();
}

class _CommunitySearchState extends State<UnifiedSearchMain> {
  final int _currentIndex = 0; // bottomnavigation index 번호
  bool isSearched = false;
  String inputText = '';
  final focusNode = FocusNode();
  List foodInfo = [false];
  List communityInfo = [false];
  List recipeInfo = [false];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BasicAppBar(title: 'Integrated Search'),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SearchBar(
                focusNode: focusNode,
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        inputText = inputText;
                        isSearched = true;
                        UnifiedSearchService.getFoodInfo(1, 1, inputText)
                            .then((value) {
                          setState(() {
                            foodInfo = value;
                          });
                        });
                        UnifiedSearchService.getCommunityInfo(inputText)
                            .then((value) {
                          setState(() {
                            communityInfo = value;
                          });
                        });
                        UnifiedSearchService.getRecipeInfo(inputText)
                            .then((value) {
                          setState(() {
                            recipeInfo = value;
                          });
                        });
                      });
                    },
                  ),
                ],
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 202, 209, 249),
                ),
                shadowColor: const MaterialStatePropertyAll(Colors.black),
                overlayColor: const MaterialStatePropertyAll(Color(0xFFAEB9F0)),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 20,
                  minHeight: 55.0,
                ),
                shape: MaterialStateProperty.all(
                  ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                hintText: globals.getText("Enter a search term"),
                onChanged: (value) {
                  inputText = value;
                },
              ),
            ),
            if (!isSearched)
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/ex/kfood_detection.png',
                      width: 300,
                      height: 300,
                    ),
                  )
                ],
              ))
            else
              Column(
                children: [
                  if (foodInfo[0])
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Food Information'),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchedFoodList(
                                                inputText: inputText,
                                              )));
                                },
                                label: Text(
                                  '${foodInfo[1].toString()} Results',
                                  style: const TextStyle(
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
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              foodInfo[2].name,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(foodInfo[2].englishName),
                            isThreeLine: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FoodInformation(
                                          foodId: foodInfo[2].id)));
                            },
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  if (communityInfo[0])
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Community'),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CommuntiyMain(
                                                inputText: inputText,
                                              )));
                                },
                                label: Text(
                                  '${communityInfo[1].toString()} Results',
                                  style: const TextStyle(
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
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              communityInfo[2].title,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  communityInfo[2].content,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Color(0xfff44336),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        communityInfo[2].likeCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xfff44336),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.mode_comment,
                                      color: Color(0xff475387),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        communityInfo[2]
                                            .commentCount
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff475387),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        '  |   ${UnifiedSearchService.calUploadTime(communityInfo[2].createdAt)}   |  ',
                                        style: const TextStyle(
                                            color: Color(0xff5b5b5b),
                                            fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      communityInfo[2].nickname,
                                      style: const TextStyle(
                                          color: Color(0xff5b5b5b),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostInformation(
                                            postId: communityInfo[2].id,
                                            isChanged: false,
                                          )));
                            },
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  if (recipeInfo[0])
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Custom Recipe'),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecipeMain(
                                                inputText: inputText,
                                              )));
                                },
                                label: Text(
                                  '${recipeInfo[1].toString()} Results',
                                  style: const TextStyle(
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
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              recipeInfo[2].title,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipeInfo[2].content,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Color(0xfff44336),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        recipeInfo[2].likeCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xfff44336),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.mode_comment,
                                      color: Color(0xff475387),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        recipeInfo[2].commentCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff475387),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        '  |   ${UnifiedSearchService.calUploadTime(recipeInfo[2].createdAt)}   |  ',
                                        style: const TextStyle(
                                            color: Color(0xff5b5b5b),
                                            fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      recipeInfo[2].nickname,
                                      style: const TextStyle(
                                          color: Color(0xff5b5b5b),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipeInformation(
                                            postId: recipeInfo[2].id,
                                            isChanged: false,
                                          )));
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
          ],
        ),
        bottomNavigationBar: BottomNav(
          currentIndex: _currentIndex,
          onTap: (index) => onItemTapped(context, index),
        ),
      ),
    );
  }
}

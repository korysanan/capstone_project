import 'package:capstone_project/camera_page/camera_page.dart';
import 'package:capstone_project/translate/language_detect.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/categoryPage/categoryMain.dart';
import 'package:capstone_project/community/communityMain.dart';
import '../customRecipe/recipeMain.dart';
import '../directions_and_map/my_location/my_location_service.dart';
import '../food_restaurant/food_select.dart';
import '../my_page/language_setting.dart';
import 'bottom.dart';
import 'on_item_tap.dart';
import 'package:carousel_slider/carousel_slider.dart'; // slider하기 위해 import
import '../globals.dart' as globals;

class KFoodBoxHome extends StatefulWidget {
  @override
  _KFoodBoxHomeState createState() => _KFoodBoxHomeState();
}

class _KFoodBoxHomeState extends State<KFoodBoxHome> {
  int _currentIndex = 0; // bottomnavigation index 번호 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0),  // 왼쪽 여백 추가
          child: Image.asset('assets/images/kfood_logo.png'),
        ),
        title: Text(
          'K-Food Box',
          style: TextStyle(
            fontSize: 24, // 글꼴 크기 설정
            fontWeight: FontWeight.w500,
            fontFamily: "Recipekorea",
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguageSelectScreen(
                    onLanguageSelected: (selectedCode) {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 10.0),
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                globals.getText("today's recommended food"),
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: globals.sessionId != null
                  ? CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: globals.foods?.map((food) => ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              food.imageUrl.startsWith('http://') || food.imageUrl.startsWith('https://') 
                                ? food.imageUrl 
                                : 'http://' + food.imageUrl,
                              width: 1000.0,
                              height: 300.0,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                                child: globals.selectedLanguageCode == 'ko' ? Text(
                                  food.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) : globals.selectedLanguageCode == 'en' ? Text(
                                  food.englishName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) : FutureBuilder<String>(
                                  future: translateText(food.englishName),  // Assuming translateText is an async function you've defined or imported
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return Text(
                                          'Error',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.data != null) {
                                        return Text(
                                          snapshot.data!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          'No translation available',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    } else {
                                      return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ); // Loading indicator while the translation loads
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList() ?? [],
                    )
                  : CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: globals.foods?.map((food) => ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              food.imageUrl.startsWith('http://') || food.imageUrl.startsWith('https://') 
                                ? food.imageUrl 
                                : 'http://' + food.imageUrl,
                              width: 1000.0,
                              height: 300.0,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                                child: globals.selectedLanguageCode == 'ko' ? Text(
                                  food.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) : globals.selectedLanguageCode == 'en' ? Text(
                                  food.englishName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) : FutureBuilder<String>(
                                  future: translateText(food.englishName),  // Assuming translateText is an async function you've defined or imported
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return Text(
                                          'Error',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.data != null) {
                                        return Text(
                                          snapshot.data!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          'No translation available',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    } else {
                                      return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ); // Loading indicator while the translation loads
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList() ?? [],
                    ),
            ),
            new Divider(height: 50.0,),
            Center(
              child: Text(
                globals.getText('Food Information'),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(221, 73, 73, 73),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.black, width: 1.0),  // 검은색 테두리 추가
              ),
              elevation: 5,
              color: Color(0xFFF1E6FF),// 카드의 배경색 설정
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Image.asset(
                      //'assets/ex/kfood_detection.png',
                      'assets/images/camera.png',
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        globals.getText('Korean Food Detection'),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              //padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryMain()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Color(0xFFF1E6FF), // 텍스트 색상 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 모서리 둥글게 처리
                    side: BorderSide(color: Colors.black, width: 1), // 테두리 색상 및 두께
                  ),
                  elevation: 5, // 그림자 높이
                ),
                child: Text(globals.getText('viewAllKoreanFoods')),
              ),
            ),
            new Divider(height: 50.0,),
            Center(
              child: Text(
                globals.getText('Bulletin Board'),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(221, 73, 73, 73),
                ),
              ),
            ),
            //SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // 테두리 색상
                            width: 1.0, // 테두리 두께
                          ),
                          borderRadius: BorderRadius.circular(10.0), // 모서리 둥글기
                        ),
                        child: CustomCard(
                          imagePath: 'assets/images/community.png',
                          label: globals.getText('community'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommuntiyMain()),
                            );
                          },
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // 테두리 색상
                          width: 1.0, // 테두리 두께
                        ),
                        borderRadius: BorderRadius.circular(10.0), // 모서리 둥글기
                      ),
                      child: CustomCard(
                        imagePath: 'assets/images/recipes.png',
                        label: globals.getText('custom recipes'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeMain()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Divider(height: 50.0,),
            Center(
              child: Text(
                globals.getText('Trip in Korea'),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(221, 73, 73, 73),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.black, width: 1.0),  // 검은색 테두리 추가
              ),
              elevation: 5,
              color: Color(0xFFF1E6FF),  // 카드의 배경색 설정
              child: InkWell(
                onTap: () async {
                  /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodSelectScreen()),
                    );
                  */
                  try {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // 사용자가 다이얼로그 바깥을 터치해도 닫히지 않도록 설정
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                    await LocationService.getCurrentLocation(); // Fetch the location
                    // After fetching location, navigate to the new screen
                    Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodSelectScreen()),
                    );
                  } catch (e) {
                    // Handle errors appropriately
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Failed to get location: $e'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } // 주석은 여기에 원래
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/images/food_map.png',
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        globals.getText('Find a Korean restaurant in South Korea'),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  CustomCard({required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 44;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Container(
          width: width,
          color: Color(0xFFF1E6FF),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Image.asset(imagePath, width: 80, height: 80),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

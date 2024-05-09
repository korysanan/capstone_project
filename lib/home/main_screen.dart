import 'package:capstone_project/camera_page/camera_page.dart';
import 'package:capstone_project/translate/language_detect.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/categoryPage/categoryMain.dart';
import 'package:capstone_project/community/communityMain.dart';
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

  final List<Map<String, String>> imageList = [
    {
      "url": "https://recipe1.ezmember.co.kr/cache/recipe/2023/06/29/a1a5a04e39879f1033ae07367dfee5251.jpg",
      "name": "Tteokbokki"
    },
    {
      "url": "https://www.sanghafarm.co.kr/sanghafarm_Data/upload/shop/product/201810/A0003528_2018102319172333992.jpg",
      "name": "Sundae"
    },
    {
      "url": "https://recipe1.ezmember.co.kr/cache/recipe/2022/08/04/d6f211ffa5c3846d5134f4d6bb00a3a51.jpg",
      "name": "Bossam"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Image.asset('assets/ex/kfood_logo.png'),
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
        //backgroundColor: Color.fromARGB(255, 117, 201, 243),
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
              child: CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: imageList.map((e) => ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        e['url']!, 
                        width: 500.0,
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
                          /*
                          child: Text(
                            e['name']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          */
                          child: FutureBuilder<String>(
                            future: translateText(e['name']!),
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
                                } else {
                                  return Text(
                                    snapshot.data!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              } else {
                                return CircularProgressIndicator(); // 로딩 중 표시
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            new Divider(height: 50.0,),
            Card(
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
                      'assets/ex/kfood_detection.png',
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'K-Food Detection',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.all(8.0),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // 테두리 색상
                          width: 1.0, // 테두리 두께
                        ),
                        borderRadius: BorderRadius.circular(10.0),  // 모서리 둥글기
                      ),
                      child: CustomCard(
                        imagePath: 'assets/ex/community.png',
                        label: globals.getText('community'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CommuntiyMain()),
                          );
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // 테두리 색상
                          width: 1.0, // 테두리 두께
                        ),
                        borderRadius: BorderRadius.circular(10.0),  // 모서리 둥글기
                      ),
                      child: CustomCard(
                        imagePath: 'assets/ex/recipes.png',
                        label: globals.getText('custom recipes'),
                        onTap: () => print('Custom Recipes Card tapped!'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.black, width: 1.0),  // 검은색 테두리 추가
              ),
              elevation: 5,
              color: Color(0xFFF1E6FF),  // 카드의 배경색 설정
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
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/ex/food_map.png',
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Find a Korean restaurant in South Korea',
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
    double width = MediaQuery.of(context).size.width / 2 - 22;

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

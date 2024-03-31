import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // slider하기 위해 import
import 'bottom.dart'; // lib/home/bottom.dart에서 bottomnavigation 불러옴 
import '../my_page/my_page_no.dart';
import '../my_page/my_page_yes.dart';
import 'on_item_tap.dart';
import '../globals.dart' as globals;
//import '../translate/language_detect.dart';


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
  // 우선 사진 링크랑 이름을 불러와서 메인화면 위에 추천음식 띄어주는거 
  // db 링크 가져오면 될 듯

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 위치 고정하는거 -> 이거 x일시 만약 키보드 올라올때 각각들도 따라 올라옴 
      appBar: AppBar(
        title: Text(globals.getText('kFoodBoxTitle')),
        centerTitle: true,
        backgroundColor: Colors.grey[400], // AppBar의 배경색을 회색으로 설정
        /*
        leading: GestureDetector(
          onTap: () {
            print("left person icon click");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person), // 아이콘
              Text('Left', style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
        */
        // 우선 이거 나중에 앱 로고 넣을 부분 

        actions: <Widget>[
          GestureDetector(
            onTap: () {
              if (globals.s == 0){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPageNo()),
                );
              }
              else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPageYes()),
                );
              } // 세션 보유 여부에 따라 mypage가 달라짐
            },
            // 세션 id 하는 식으로
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person),
                Text(globals.getText('myPageTitle'), style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.only(top: 10.0),
        children: [
          Center(
            child: Text(
              globals.getText("today's recommended food"),
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Center(
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              // CarouselSlider 내부에서 FutureBuilder를 사용하여 번역된 텍스트 표시
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
                        child: Text(
                          e['name']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*
                        // FutureBuilder를 사용하여 비동기적으로 텍스트 번역 결과 반영
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
                        */
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
          new Divider(height: 50.0,),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print("view all Korean foods"); // 카테고리 들어가는 화면 넣을 부분 
              },
              child: Text(globals.getText('viewAllKoreanFoods')),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text(globals.getText('community'), style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(),
                ListTile(
                  title: Text('Kimchi wow!!'),
                  trailing: Text('2 minutes ago'),
                ),
                ListTile(
                  title: Text('Korean food recomme ...'),
                  trailing: Text('1 days ago'),
                ),
                ListTile(
                  title: Text('Hello'),
                  trailing: Text('02/01'),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text(globals.getText('custom recipes'), style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(),
                ListTile(
                  title: Text('My Kimchi recipe'),
                  trailing: Text('2 minutes ago'),
                ),
                ListTile(
                  title: Text("Here's my jjampp..."),
                  trailing: Text('1 days ago'),
                ),
                ListTile(
                  title: Text('Hello'),
                  trailing: Text('12/21'),
                ),
              ],
            ),
          ),
          // 우선 위에 card 부분은 일단 text로 대체했는데 나중에 db 링크 이용해서 불러오는 식으로 코드 수정하면 될듯 
        ],
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
      // lib/home/bottom.dart에서 bottomNavigation 불러오기 
    );
  }

}
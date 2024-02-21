import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // slider하기 위해 import

class KFoodBoxHome extends StatefulWidget {
  @override
  _KFoodBoxHomeState createState() => _KFoodBoxHomeState();
}

class _KFoodBoxHomeState extends State<KFoodBoxHome> {
  int _currentIndex = 0;
  
  final List<Map<String, String>> imageList = [
    {
      "url": "https://recipe1.ezmember.co.kr/cache/recipe/2023/06/29/a1a5a04e39879f1033ae07367dfee5251.jpg",
      "name": "tteokbokki"
    },
    {
      "url": "https://www.sanghafarm.co.kr/sanghafarm_Data/upload/shop/product/201810/A0003528_2018102319172333992.jpg",
      "name": "sundae"
    },
    {
      "url": "https://recipe1.ezmember.co.kr/cache/recipe/2022/08/04/d6f211ffa5c3846d5134f4d6bb00a3a51.jpg",
      "name": "Bossam"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('K-Food Box'),
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
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              print("right person icon click");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person),
                Text('My Page', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.only(top: 40.0),
        children: [
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
                      e['url']!, // 여기서 `!`를 사용하여 `e['url']`이 null이 아님을 단언/ 안하면 오류 발생 
                      width: 1050.0,
                      height: 350.0,
                      fit: BoxFit.cover,
                    ),
                    Positioned( // 이미지 위에 텍스트 위치
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black54, // 반투명 배경
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                        child: Text(
                          e['name']!, // 텍스트 내용
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                print("view all Korean foods");
              },
              child: Text('View All Korean foods'),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Community', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(),
                ListTile(
                  title: Text('Kimchi wow!!'),
                  trailing: Text('2 minutes ago'),
                ),
                ListTile(
                  title: Text('Korean food recomme...'),
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
                  title: Text('Custom Recipes', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black, 
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'rocket',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
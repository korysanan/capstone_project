import 'package:flutter/material.dart';

import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import 'region_select.dart';
import 'restaurant_info.dart';

class RestaurantDetailsPage extends StatelessWidget {
  int _currentIndex = 0;
  final int food_id;
  final String food_name;
  final Map<String, dynamic> restaurantData;

  RestaurantDetailsPage({Key? key, required this.restaurantData, required this.food_id, required this.food_name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int restaurantCount = restaurantData['restaurants'].length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push( // 새 페이지로 이동
              context,
              MaterialPageRoute(builder: (context) => RegionSelectScreen(food_id : food_id, food_name: food_name,)),
            );
          },
        ),
        title: Text('Select Restaurants'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurantCount,
        itemBuilder: (BuildContext context, int index) {
          var restaurant = restaurantData['restaurants'][index];
          return InkWell(
            onTap: () {
              Navigator.push( // 새 페이지로 이동
                context,
                MaterialPageRoute(builder: (context) => RestaurantPage(restaurant_info: restaurant)),
              );
            },
            child: Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: [
                restaurant['imageUrl'] != null && restaurant['imageUrl'].isNotEmpty
                ? Image.network(
                    restaurant['imageUrl'],
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // 네트워크 이미지 로딩 실패 시 에러 아이콘 표시
                    },
                  )
                : Image.asset(
                    'assets/images/image_comming_soon.png', // 로컬 에셋에서 이미지 로드
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text('업체명: ${restaurant['name']}'),
                    subtitle: restaurant['visitorRating'] != null
                      ? Text('평점: ${restaurant['visitorRating']}')
                      : null,
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
}

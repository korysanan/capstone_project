import 'package:flutter/material.dart';
import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import 'region_select.dart';
import 'restaurant_info.dart';
import 'dart:math';
import '../globals.dart' as globals;

const List<String> list = <String>[
  'Visitor Rating',
  'Review Count',
  'Distance'
];

class RestaurantDetailsPage extends StatefulWidget {
  final int food_id;
  final String food_name;
  Map<String, dynamic> restaurantData;

  RestaurantDetailsPage(
      {Key? key,
      required this.restaurantData,
      required this.food_id,
      required this.food_name})
      : super(key: key);

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  String dropdownValue = list.first;
  String sort = "LATEST";
  List<dynamic> restaurantList = [];

  void sortReataurantList() {
    switch (sort) {
      case 'Visitor Rating':
        restaurantList.sort((a, b) {
          var ratingA = a["visitorRating"];
          var ratingB = b["visitorRating"];
          if (ratingA == null && ratingB == null) {
            return 0;
          } else if (ratingA == null) {
            return 1; // null 값을 가진 항목은 우선순위를 낮게 처리
          } else if (ratingB == null) {
            return -1; // null 값을 가진 항목은 우선순위를 낮게 처리
          } else {
            return ratingB.compareTo(ratingA); // visitorRating 기준으로 내림차순 정렬
          }
        });
        break;
      case 'Review Count':
        restaurantList.sort((a, b) {
          var ratingA = a["visitorReviewCount"];
          var ratingB = b["visitorReviewCount"];

          if (ratingA == null && ratingB == null) {
            return 0;
          } else if (ratingA == null) {
            return 1; // null 값을 가진 항목은 우선순위를 낮게 처리
          } else if (ratingB == null) {
            return -1; // null 값을 가진 항목은 우선순위를 낮게 처리
          } else {
            return ratingB.compareTo(ratingA); // visitorRating 기준으로 내림차순 정렬
          }
        });
        break;
      case 'Distance':
        restaurantList.sort((a, b) {
          var distanceA = euclideanDistance(
              globals.my_latitude,
              globals.my_longitude,
              double.parse(a["latitude"]),
              double.parse(a["longitude"]));
          var distanceB = euclideanDistance(
              globals.my_latitude,
              globals.my_longitude,
              double.parse(b["latitude"]),
              double.parse(b["longitude"]));

          return distanceA.compareTo(distanceB);
        });
        break;
    }
  }

  double euclideanDistance(
      double? lat1, double? lon1, double? lat2, double? lon2) {
    var dx = lat2! - lat1!;
    var dy = lon2! - lon1!;
    return sqrt(dx * dx + dy * dy);
  }

  @override
  void initState() {
    setState(() {
      restaurantList = widget.restaurantData['restaurants'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int restaurantCount = restaurantList.length;
    int _currentIndex = 0;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              // 새 페이지로 이동
              context,
              MaterialPageRoute(
                builder: (context) => RegionSelectScreen(
                  food_id: widget.food_id,
                  food_name: widget.food_name,
                )),
            );
          },
        ),
        title: const Text('Select Restaurants'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      sort = value;
                      sortReataurantList();
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: restaurantCount,
              itemBuilder: (BuildContext context, int index) {
                var restaurant = restaurantList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      // 새 페이지로 이동
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RestaurantPage(restaurant_info: restaurant)),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        restaurant['imageUrl'] != null &&
                                restaurant['imageUrl'].isNotEmpty
                            ? Image.network(
                                restaurant['imageUrl'],
                                width: double.infinity,
                                height: 200.0,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons
                                      .error); // 네트워크 이미지 로딩 실패 시 에러 아이콘 표시
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

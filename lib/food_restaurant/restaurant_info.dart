import 'package:flutter/material.dart';

import '../directions_and_map/directions/filterling.dart';
import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import '../directions_and_map/map/naver_map.dart';

class RestaurantPage extends StatefulWidget {
  final Map<String, dynamic> restaurant_info;

  RestaurantPage({Key? key, required this.restaurant_info}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  int _currentIndex = 0;

  late String restaurantName;
  late String address;
  late String phoneNumber;
  late String imageUrl;
  late int visitorReviewCount;
  late double visitorRating;
  late int blogReviewCount;
  late int photoReviewCount;
  late double latitude;
  late double longitude;
  late String information;
  late String additionalExplanation;
  late String homepageUrl;
  late int all_review_count;

  @override
  void initState() {
    super.initState();
    restaurantName = widget.restaurant_info['name'] ?? 'Unknown Restaurant';
    address = widget.restaurant_info['address'] ?? 'No address available';
    phoneNumber = widget.restaurant_info['phoneNumber'] ?? 'No phone number available';
    imageUrl = widget.restaurant_info['imageUrl'] ?? 'assets/images/image_comming_soon.png';
    visitorReviewCount = widget.restaurant_info['visitorReviewCount']?.toInt() ?? 0;
    visitorRating = widget.restaurant_info['visitorRating']?.toDouble() ?? 0.0;
    blogReviewCount = widget.restaurant_info['blogReviewCount']?.toInt() ?? 0;
    photoReviewCount = widget.restaurant_info['photoReviewCount']?.toInt() ?? 0;
    String latitudeStr = widget.restaurant_info['latitude'] ?? '0.0';
    String longitudeStr = widget.restaurant_info['longitude'] ?? '0.0';
    latitude = double.tryParse(latitudeStr) ?? 0.0;
    longitude = double.tryParse(longitudeStr) ?? 0.0;
    information = widget.restaurant_info['information'] ?? 'No additional information available';
    additionalExplanation = widget.restaurant_info['additionalExplanation'] ?? 'No additionalExplanation available';
    homepageUrl = widget.restaurant_info['homepageUrl'] ?? 'No homepage available';

    // 여기에서 all_review를 계산합니다.
    all_review_count = visitorReviewCount + blogReviewCount + photoReviewCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Restaurant Info'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.restaurant_info['name'] ?? 'Unknown Restaurant',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 자식들 사이의 간격을 균등하게 분배
                children: <Widget>[
                  Card(
                    elevation: 4.0, // 카드의 그림자 깊이
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 카드 내부의 패딩
                      child: Text(
                        '⭐ : ${visitorRating} (${visitorReviewCount})', // 평점 데이터
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.all(20), // 다이얼로그의 패딩을 조절하여 크기를 증가
                            child: Container(
                              width: double.infinity,
                              height: 300, // 컨테이너 높이를 증가시켜 버튼과 취소 버튼을 포함할 공간 확보
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼 사이에 공간을 균등하게 배분
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼 사이에 공간을 균등하게 배분
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => FilterScreen(
                                              latitude: latitude,
                                              longitude: longitude
                                            )),
                                          );
                                          // 첫 번째 이미지 버튼 기능FilterScreen
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min, // 내용에 맞게 최소 크기 설정
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/directions.png', // 첫 번째 이미지 로드
                                              width: 100, // 이미지의 너비 설정
                                              height: 100, // 이미지의 높이 설정
                                            ),
                                            Text('Directions') // 이미지 아래 텍스트
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => RestaurantMap(
                                              restaurantName: restaurantName,
                                              address: address,
                                              phoneNumber: phoneNumber,
                                              visitorRating: visitorRating,
                                              latitude: latitude,
                                              longitude: longitude
                                            )),
                                          );
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min, // 내용에 맞게 최소 크기 설정
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/map.png', // 두 번째 이미지 로드
                                              width: 100, // 이미지의 너비 설정
                                              height: 100, // 이미지의 높이 설정
                                            ),
                                            Text('Map') // 이미지 아래 텍스트
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // 다이얼로그 창을 닫음
                                    },
                                    child: Text('Cancel'),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black, backgroundColor: Colors.blue.shade500, // 텍스트 색상 설정
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 4.0, // 카드의 그림자 깊이
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // 카드 내부의 패딩
                        child: Text(
                          '지도 및 길찾기', // 방문자 리뷰 수 데이터
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  )
                ]
              ),
            ),
            Text(
              '전화번호: ${phoneNumber}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '주소: ${address}',
              style: TextStyle(fontSize: 18),
            ),
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

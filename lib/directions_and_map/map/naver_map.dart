import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../home/bottom.dart';
import '../../home/on_item_tap.dart';
import '../../globals.dart' as globals;

class RestaurantMap extends StatefulWidget {
  final String restaurantName;
  final String address;
  final String phoneNumber;
  final double visitorRating;

  RestaurantMap({
    Key? key, 
    required this.restaurantName, 
    required this.address, 
    required this.phoneNumber, 
    required this.visitorRating, 
  }) : super(key: key); 
  
  @override
  _RestaurantMapState createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {
  int _currentIndex = 0;
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Restaurant Map'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: WebView(
        initialUrl: 'http://3.35.120.84/restaurant_map.html',//'http://10.0.2.2/flutter/odsay_test.html',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageFinished: (String url) {
          _injectDataIntoWebView();
        },
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
  
  void _injectDataIntoWebView() {
    // JavaScript 함수에 데이터 주입
    _controller.runJavascript(
        "updateData(${globals.arr_latitude}, ${globals.arr_longitude}, '${widget.restaurantName}', '${widget.address}', '${widget.phoneNumber}', ${widget.visitorRating});");
  }
}
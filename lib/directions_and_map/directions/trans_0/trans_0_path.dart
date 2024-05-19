import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import '../../../globals.dart' as globals;
import '../../../home/bottom.dart';
import '../../../home/on_item_tap.dart';

class PathDetailScreen extends StatefulWidget {
  final Map<String, dynamic> jsonMap2;

  PathDetailScreen({
    required this.jsonMap2,
  });

  @override
  _PathDetailScreenState createState() => _PathDetailScreenState();
}

class _PathDetailScreenState extends State<PathDetailScreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Path Detail'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: WebView(
        initialUrl: 'http://10.0.2.2/flutter/odsay_test_4.html', // Adjust the URL according to your server setup
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
    Map<String, dynamic> data = {
      'sx': globals.my_longitude,
      'sy': globals.my_latitude,
      'ex': globals.arr_longitude,
      'ey': globals.arr_latitude,
      //'jsonMap2': widget.jsonMap2, // Include the jsonMap2 data
    };
    String jsonData = jsonEncode(data);
    _controller.runJavascript("updateData('$jsonData');");
  }
}

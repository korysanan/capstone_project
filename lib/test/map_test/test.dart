import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapWebView extends StatefulWidget {
  @override
  _MapWebViewState createState() => _MapWebViewState();
}

class _MapWebViewState extends State<MapWebView> {
  late WebViewController _controller;

  final double latitude = 37.3874119;
  final double longitude = 126.8116406;
  final String name = "ㅎㅇㅎㅇ";
  final String address = "안녕하신지";
  final String phoneNumber = "0507-12320-7097";
  final double rating = 4.14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naver Map in WebView'),
      ),
      body: WebView(
        initialUrl: 'http://10.0.2.2/flutter/value_test.html',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageFinished: (String url) {
          _injectDataIntoWebView();
        },
      ),
    );
  }

  void _injectDataIntoWebView() {
    // JavaScript 함수에 데이터 주입
    _controller.runJavascript(
        "updateData($latitude, $longitude, '$name', '$address', '$phoneNumber', $rating);");
  }
}

void main() => runApp(MaterialApp(home: MapWebView()));

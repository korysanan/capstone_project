import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import '../../../globals.dart' as globals;

class WebViewScreen extends StatefulWidget {
  final Map<String, dynamic> modifiedJsonData;

  WebViewScreen({required this.modifiedJsonData});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  late String modifiedJsonDataString;

  @override
  void initState() {
    super.initState();
    modifiedJsonDataString = jsonEncode(widget.modifiedJsonData);
  }

  Future<void> _sendDataToWebView() async {
    // JSON 문자열을 JavaScript 코드에서 안전하게 사용할 수 있도록 이스케이프 처리합니다.
    String escapedJsonDataString = modifiedJsonDataString.replaceAll("\\", "\\\\").replaceAll("'", "\\'");

    // JavaScript로 전송할 데이터에 전역 변수를 포함시킵니다.
    String jsCommand = """
      window.receiveDataFromFlutter('$escapedJsonDataString', ${globals.my_longitude}, ${globals.my_latitude}, ${globals.arr_longitude}, ${globals.arr_latitude});
    """;

    _controller.runJavascript(jsCommand);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Path Details'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'),
          ),
        ],
      ),
      body: WebView(
        initialUrl: 'http://3.35.120.84/tran_1_direction.html', // 웹뷰의 초기 URL 설정
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageFinished: (String url) {
          // 페이지 로드 완료 후 데이터를 전송합니다.
          _sendDataToWebView();
        },
      ),
    );
  }
}

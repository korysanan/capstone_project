import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../globals.dart' as globals;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지도 경로 보기'),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'http://10.0.2.2/flutter/ot2.html', // 원격 HTML 파일 로드
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
    if (_controller != null) {
      String script = """
        console.log('searchDrivingPath called with: ${globals.my_longitude}, ${globals.my_latitude}, ${globals.arr_longitude}, ${globals.arr_latitude}');
        searchDrivingPath(${globals.my_longitude}, ${globals.my_latitude}, ${globals.arr_longitude}, ${globals.arr_latitude});
      """;
      _controller!.runJavascript(script);
    }
  }
}

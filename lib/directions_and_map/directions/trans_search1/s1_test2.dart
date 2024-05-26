import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class WebViewScreen extends StatefulWidget {
  final Map<String, dynamic> modifiedJsonData;

  WebViewScreen({required this.modifiedJsonData});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    String modifiedJsonDataString = JsonEncoder.withIndent('  ').convert(widget.modifiedJsonData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Path Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: 'http://10.0.2.2/flutter/t1_test.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              onPageFinished: (String url) {
                _controller.runJavascript("document.getElementById('jsonData').innerText = `$modifiedJsonDataString`;");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print(modifiedJsonDataString);
              },
              child: Text('Send to Server'),
            ),
          ),
        ],
      ),
    );
  }
}

// Add your function to send JSON data to the server here
// void sendJsonToServer(Map<String, dynamic> jsonData) {
//   // Implement your server communication logic here
// }

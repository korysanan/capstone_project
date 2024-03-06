import 'dart:io';
import 'package:flutter/material.dart';

class ImageInformationPage extends StatelessWidget {
  final File image;
  final List<String> names;

  ImageInformationPage({required this.image, required this.names});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Korean Food Detection'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.file(image),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20), // 아래쪽에 여백을 추가합니다.
            // List<String>을 하나의 String으로 변환하여 보여줍니다.
            child: Text(names.join(', '), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('What is Korean Food Detection?'),
          ),
        ],
      ),
    );
  }
}


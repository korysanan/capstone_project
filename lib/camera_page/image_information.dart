import 'dart:io';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class ImageInformationPage extends StatelessWidget {
  final File image;
  final List<dynamic> food_info;

  ImageInformationPage({required this.image, required this.food_info});

  @override
  Widget build(BuildContext context) {
    print(food_info);
    // maxWidth와 maxHeight는 예시값입니다. 실제 이미지 또는 디스플레이의 크기에 따라 적절히 조정해야 합니다.
    double maxWidth = 400;
    double maxHeight = 300;

    List<Widget> buildPositionedWidgets() {
      List<Widget> positionedWidgets = [];
      for (var info in food_info) {
        double xmin = double.parse(info["xmin"].toStringAsFixed(2));
        double ymin = double.parse(info["ymin"].toStringAsFixed(2));
        double xmax = double.parse(info["xmax"].toStringAsFixed(2));
        double ymax = double.parse(info["ymax"].toStringAsFixed(2));

        double left = xmin;
        double top = ymin;
        double right = maxWidth - xmax;
        double bottom = maxHeight - ymax;

        positionedWidgets.add(
          Positioned(
            left: left,
            top: top,
            right: right,
            bottom: bottom,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.red, // 테두리 색상
                  width: 5, // 테두리 두께
                ),
              ),
            ),
          ),
        );

        positionedWidgets.add(
          Positioned(
            left: left,
            top: top,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red.shade100, // 상자 배경 색상
                border: Border.all(
                  color: Colors.red, // 테두리 색상
                  width: 2, // 테두리 두께
                ),
                borderRadius: BorderRadius.circular(4), // 상자 모서리 둥글게 처리
              ),
              child: Text(
                info["name"],
                style: TextStyle(
                  color: Colors.black, // 텍스트 색상
                  fontSize: 14, // 텍스트 크기
                ),
              ),
            ),
          ),
        );
      }
      return positionedWidgets;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(globals.getText('Korean Food Detection')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Stack(
                children: [
                  Image.file(image),
                  ...buildPositionedWidgets(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(food_info.map((info) => info["name"]).join(', '), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(globals.getText('What is Korean Food Detection?')),
          ),
        ],
      ),
    );
  }
}

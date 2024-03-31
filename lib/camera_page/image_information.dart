import 'dart:io';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class ImageInformationPage extends StatelessWidget {
  final File image;
  final List<dynamic> food_info;
  final Size size; 

  ImageInformationPage({required this.image, required this.food_info, required this.size});

  String getDisplayName(String name) {
    switch (name) {
      case "food120":
        return "Sundae";
      case "food72":
        return "Tteokbokki";
      case "food61":
        return "Kimbap";
      default:
        return name; // 일치하는 조건이 없으면 원래의 name 값을 반환
    }
  }

  @override
  Widget build(BuildContext context) {    
    double image_width = size.width;
    double image_height = size.height;
    double maxWidth = 400; // 가로는 400 고정 
    double maxHeight = image_height / image_width * 400; // 세로는 가로 사이즈에 비례 image_width : image_height = maxWidth : maxHeight
    

    List<Widget> buildPositionedWidgets() {
      List<Widget> positionedWidgets = [];
      for (var info in food_info) {
        double xmin = maxWidth / image_width * double.parse(info["xmin"].toStringAsFixed(2));
        double ymin = maxHeight / image_height * double.parse(info["ymin"].toStringAsFixed(2));
        double xmax = maxWidth / image_width * double.parse(info["xmax"].toStringAsFixed(2));
        double ymax = maxHeight / image_height * double.parse(info["ymax"].toStringAsFixed(2));
        // 사진 비례에 맞게 크기 조정
        
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
                getDisplayName(info["name"]), // 함수를 사용하여 조건에 따라 텍스트 출력
                // info["name"],
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
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Image.file(image),
                      ...buildPositionedWidgets(),
                    ],
                  ),
                  Column(
                    children: food_info.map((info) {
                      return Column(
                        children: <Widget>[
                          Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(getDisplayName(info["name"]), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text('Explanation -> '),
                                ),
                                ListTile(
                                  title: Text('Custom Recipes -> '),
                                ),
                              ],
                            ), 
                          ),
                          Divider(height: 50.0,),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
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

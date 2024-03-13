import 'package:flutter/material.dart';

class ImageTestWidget extends StatefulWidget {
  @override
  _ImageTestWidgetState createState() => _ImageTestWidgetState();
}

class _ImageTestWidgetState extends State<ImageTestWidget> {
  bool _showWidget = false;
  bool _showWidget2 = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Korean Food Detection'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Image.network(
                  'https://www.sanghafarm.co.kr/sanghafarm_Data/upload/shop/product/201810/A0003528_2018102319172333992.jpg',
                ),
                if (_showWidget)
                  Positioned(
                    left: 80, // 왼쪽 상단 모서리의 X좌표
                    top: 100, // 왼쪽 상단 모서리의 Y좌표
                    right: 0, // 오른쪽 아래 모서리까지의 거리를 오른쪽으로부터 설정
                    bottom: 80, // 오른쪽 아래 모서리까지의 거리를 아래쪽으로부터 설정
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
                if (_showWidget2)
                  Positioned( // 이미지 위에 텍스트 위치
                    left: 160, // 왼쪽 상단 모서리의 X좌표
                    top: 70, // 왼쪽 상단 모서리의 Y좌표
                    right: 120, // 오른쪽 아래 모서리까지의 거리를 오른쪽으로부터 설정
                    bottom: 310,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // 모서리를 둥글게 하는 정도 설정
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.blue.shade100, // 반투명 배경 적용
                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                        child: Text(
                          'sundae',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )

              ],
            ),
            new Divider(height: 20.0,),
            InkWell(
              onTap: () {
                setState(() {
                  _showWidget = !_showWidget;
                });
              },
              child: Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('food name', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('confidence'),
                    ),
                    ListTile(
                      title: Text('aa'),
                    ),
                  ],
                ),
              ),
            ),
            new Divider(height: 20.0,),
            InkWell(
              onTap: () {
                setState(() {
                  _showWidget2 = !_showWidget2;
                });
              },
              child: Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('food name', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('confidence'),
                    ),
                    ListTile(
                      title: Text('aa'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
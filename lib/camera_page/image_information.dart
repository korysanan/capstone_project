import 'dart:io';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../bookmark/foods_bookmark/foods_bookmark_service.dart';
import '../bookmark/foods_bookmark/foods_bookmark_data.dart';
import 'camera_page.dart';
import '../home/main_screen.dart';

class ImageInformationPage extends StatefulWidget {
  final File image;
  final List<dynamic> food_info;
  final Size size;

  ImageInformationPage({required this.image, required this.food_info, required this.size});

  @override
  _ImageInformationPageState createState() => _ImageInformationPageState();
}

class _ImageInformationPageState extends State<ImageInformationPage> {
  late List<bool> bookmarkStatus;
  final double maxWidth = 400.0;
  late List<dynamic> uniqueFoodInfo;
/*
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
*/
  @override
  void initState() {
    super.initState();

    // Filter unique names right here
    Set<String> seenNames = {};
    uniqueFoodInfo = widget.food_info.where((info) {
      return seenNames.add(info['name']);
    }).toList();

    // Initialize bookmark status for unique items
    bookmarkStatus = List<bool>.filled(uniqueFoodInfo.length, false);
    fetchInitialBookmarks();
  }

  void fetchInitialBookmarks() async {
    await BookmarkService.fetchBookmarks();
    setState(() {
      for (int i = 0; i < uniqueFoodInfo.length; i++) {
        var info = uniqueFoodInfo[i];
        int foodId = int.parse(info["class"].toString());
        bookmarkStatus[i] = BookmarkData.isBookmarked(foodId);
      }
    });
  }

  void toggleBookmark(int index, int foodId) async {
    if (bookmarkStatus[index]) {
      await BookmarkService.deleteBookmark(foodId);
    } else {
      await BookmarkService.addBookmark(foodId);
    }
    setState(() {
      bookmarkStatus[index] = !bookmarkStatus[index];
    });
  }

  List<Widget> buildPositionedWidgets(double imageWidth, double imageHeight) {
    List<Widget> positionedWidgets = [];
    double maxHeight = imageHeight / imageWidth * maxWidth; // 세로는 가로 사이즈에 비례

    for (var info in widget.food_info) {
      double xmin = maxWidth / imageWidth * double.parse(info["xmin"].toStringAsFixed(2));
      double ymin = maxHeight / imageHeight * double.parse(info["ymin"].toStringAsFixed(2));
      double xmax = maxWidth / imageWidth * double.parse(info["xmax"].toStringAsFixed(2));
      double ymax = maxHeight / imageHeight * double.parse(info["ymax"].toStringAsFixed(2));

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
                color: Colors.red,
                width: 5,
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
              color: Colors.red.shade100,
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              info["name"],
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }
    return positionedWidgets;
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = widget.size.width;
    double imageHeight = widget.size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()),
            );
          },
        ),
        title: Text(globals.getText('Korean Food Detection')),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => KFoodBoxHome()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.file(widget.image),
              ...buildPositionedWidgets(imageWidth, imageHeight),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: uniqueFoodInfo.asMap().entries.map((entry) {
                  int idx = entry.key;
                  var info = entry.value;
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(info["name"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          trailing: IconButton(
                            icon: bookmarkStatus[idx] ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border_outlined),
                            onPressed: () => toggleBookmark(idx, int.parse(info["class"].toString())),
                          ),
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
                  );
                }).toList(),
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
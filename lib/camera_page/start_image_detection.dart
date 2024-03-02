import 'dart:io';
import 'package:flutter/material.dart';
import 'camera_page.dart';

class ImageDetailsPage extends StatelessWidget {
  final File image;

  ImageDetailsPage({required this.image});

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
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.play_circle),
            label: Text(
              'Start Image Detection',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              print('Start Image Detection');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.yellow.shade100,
              minimumSize: Size(double.infinity, 100),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.undo),
            label: Text(
              'Undo',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade400,
              minimumSize: Size(double.infinity, 100),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('What is Korean Food Detection?'),
          ),
          SizedBox(height: 20), // Add spacing at the bottom if needed.
        ],
      ),
    );
  }
}

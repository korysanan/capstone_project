import 'dart:io';
import 'package:flutter/material.dart';
import '../camera_page/camera_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 파싱을 위해 추가
import 'image_information.dart';

class ImageDetailsPage extends StatelessWidget {
  final File image;

  ImageDetailsPage({required this.image});

  Future<void> uploadImage(BuildContext context, File image) async {
    showDialog(
      context: context,
      barrierDismissible: false, // 사용자가 다이얼로그 바깥을 터치해도 닫히지 않도록 설정
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    // 서버 업로드 로직
    var uri = Uri.parse('http://43.201.164.78:5000/predict');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();

    Navigator.of(context).pop(); // 로딩 다이얼로그 닫기

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      try {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> jsonResponse = jsonDecode(responseBody);
        List<String> names = [];
        for (var item in jsonResponse) {
          //print('xmin: ${item["xmin"]}, ymin: ${item["ymin"]}, xmax: ${item["xmax"]}, ymax: ${item["ymax"]}, confidence: ${item["confidence"]}, class: ${item["class"]}, name: ${item["name"]}');
          names.add(item["name"]); // 리스트에 이름 추가
        }
        if (names.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImageInformationPage(image: image, names: names)), // 수정된 부분
          );
        }
      } catch (e) {
        print('Error parsing server response: $e');
      }
    } else {
      print('Image upload failed');
      // 실패 처리 로직 (예: 실패 알림 표시)
    }
  }

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
              uploadImage(context, image); // 여기에서 context와 함께 uploadImage 호출
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
import 'dart:io';
//import 'package:capstone_project/translate/language_detect.dart';
import 'package:flutter/material.dart';
import '../translate/language_detect.dart';
import 'camera_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 파싱을 위해 추가
import 'image_information.dart';
import '../globals.dart' as globals;

class ImageDetailsPage extends StatelessWidget {
  final File image;
  final Size size;

  const ImageDetailsPage({super.key, required this.image, required this.size});

  Future<void> uploadImage(BuildContext context, File image) async {
    showDialog(
      context: context,
      barrierDismissible: false, // 사용자가 다이얼로그 바깥을 터치해도 닫히지 않도록 설정
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // 서버 업로드 로직
    var uri = Uri.parse('http://3.35.120.84:5000/predict');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      try {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> jsonResponse = jsonDecode(responseBody);
        List<dynamic> foodInfo = [];
        for (var item in jsonResponse) {
          //print('xmin: ${item["xmin"]}, ymin: ${item["ymin"]}, xmax: ${item["xmax"]}, ymax: ${item["ymax"]}, confidence: ${item["confidence"]}, class: ${item["class"]}, name: ${item["name"]}');
          foodInfo.add(item); // 모든 정보 food_info의 저장
        }
        if (foodInfo.isNotEmpty) {
          await fetchFoodDetailsAndNavigate(foodInfo, context, image);
        }
      } catch (e) {
        print('Error parsing server response: $e');
      }
    } else {
      print('Image upload failed');
      // 실패 처리 로직 (예: 실패 알림 표시)
    }
  }

  Future<void> fetchFoodDetailsAndNavigate(
      List<dynamic> foodInfo, BuildContext context, File image) async {
    List<Map<String, dynamic>> foodDetails = [];
    Map<int, Map<String, dynamic>> labelLookup = {};

    for (var item in foodInfo) {
      var response = await http.get(
        Uri.parse('http://api.kfoodbox.click/labelled-foods/${item['class']}'),
        headers: {
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data != null && data['labelId'] != null) {
          labelLookup[data['labelId']] = {
            'id': data['id'],
            'name': globals.selectedLanguageCode == 'ko'
                ? data['name']
                : globals.selectedLanguageCode == 'en'
                    ? data['englishName']
                    : await translateText(data['englishName']),
          };  
        }
      }
    }

    foodDetails = foodInfo
        .map((food) {
          var details = labelLookup[food['class']];
          if (details != null) {
            return {
              'xmin': food['xmin'],
              'ymin': food['ymin'],
              'xmax': food['xmax'],
              'ymax': food['ymax'],
              'id': details['id'],
              'name': details['name'],
            };
          } else {
            return null; // Or handle the case where details are not found
          }
        })
        .where((element) => element != null)
        .cast<Map<String, dynamic>>()
        .toList();
    print(foodDetails);
    Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageInformationPage(
              image: image, food_info: foodDetails, size: size)), // 수정된 부분
    );
  }

  @override
  Widget build(BuildContext context) {
    print(size);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()),
            );
          },
        ),
        title: Text(globals.getText('Korean Food Detection')),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.file(image),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.play_circle),
            label: Text(
              globals.getText('Start Image Detection'),
              style: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              uploadImage(context, image); // 여기에서 context와 함께 uploadImage 호출
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow.shade100,
              minimumSize: const Size(double.infinity, 100),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.undo),
            label: Text(
              globals.getText('Undo'),
              style: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade400,
              minimumSize: const Size(double.infinity, 100),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showDialog(context);
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                globals.getText('What to look out for when detecting Korean food'),
                style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(globals.getText('Precautions for Korean Food Detection')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(globals.getText('The results may not necessarily be accurate. Detections may be poor in the following cases.')),
              SizedBox(height: 10),
              Text(globals.getText('(1) If the picture is small in size or the picture quality is poor')),
              SizedBox(height: 10),
              Text(globals.getText("(2) If the food doesn't appear completely in the picture")),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

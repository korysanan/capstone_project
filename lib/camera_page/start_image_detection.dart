import 'dart:io';
import 'package:flutter/material.dart';
import '../home/main_screen.dart';
import '../translate/language_detect.dart';
import 'camera_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON parsing
import 'image_information.dart';
import '../globals.dart' as globals;

class ImageDetailsPage extends StatelessWidget {
  final File image;
  final Size size;

  const ImageDetailsPage({super.key, required this.image, required this.size});

  Future<void> uploadImage(BuildContext context, File image) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

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
          foodInfo.add(item); // Store all information in food_info
        }
        if (foodInfo.isNotEmpty) {
          await fetchFoodDetailsAndNavigate(foodInfo, context, image);
        }
        else {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('No Match'),
                content: Text('There is no match.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print('Error parsing server response: $e');
      }
    } else {
      print('Image upload failed');
      // Handle failure (e.g., show a failure notification)
    }
  }

  Future<void> fetchFoodDetailsAndNavigate(List<dynamic> foodInfo, BuildContext context, File image) async {
    List<Map<String, dynamic>> foodDetails = [];
    Map<int, Map<String, dynamic>> labelLookup = {};

    for (var item in foodInfo) {
      var response = await http.get(
        Uri.parse('https://api-v2.kfoodbox.click/labelled-foods/${item['class']}'),
        headers: {
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data != null && data['labelId'] != null) {
          String englishName = globals.selectedLanguageCode == 'ko'
              ? data['name']
              : globals.selectedLanguageCode == 'en'
                  ? data['englishName']
                  : await translateText(data['englishName']);

          labelLookup[data['labelId']] = {
            'id': data['id'],
            'name': data['name'],
            'englishName': englishName ?? 'Unknown', // Provide a default value
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
              'englishName': details['englishName'],
            };
          } else {
            return null; // Handle the case where details are not found
          }
        })
        .where((element) => element != null)
        .cast<Map<String, dynamic>>()
        .toList();
    Navigator.of(context).pop(); // Close loading dialog
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageInformationPage(
              image: image, food_info: foodDetails, size: size)),
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
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
              uploadImage(context, image); // Call uploadImage with context
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

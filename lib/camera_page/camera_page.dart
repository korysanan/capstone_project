import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'start_image_detection.dart';
import '../globals.dart' as globals;
import '../home/main_screen.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;

Future<void> _takePicture() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path); // 이미지 파일 사용
    final imageSize = await _getImageSize(imageFile);

    // 상태 업데이트 및 이미지 상세 페이지로 이동
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageDetailsPage(image: imageFile, size: imageSize),
      ));
    });
  }
}

Future<void> _pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path); // 갤러리에서 선택한 원본 이미지 파일 사용
    final imageSize = await _getImageSize(imageFile);

    // 상태 업데이트 및 이미지 상세 페이지로 이동
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageDetailsPage(image: imageFile, size: imageSize),
      ));
    });
  }
}

Future<Size> _getImageSize(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  final image = img.decodeImage(bytes);
  return Size(image!.width.toDouble(), image.height.toDouble());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KFoodBoxHome()),
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
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _image == null
                ? Center(
                    child: Text(
                      globals.getText('Image is empty'),
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Image.file(_image!),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text(
              globals.getText('Take a Picture'),
              style: TextStyle(fontSize: 20),
            ),
            onPressed: _takePicture,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF1E6FF),
              minimumSize: Size(double.infinity, 100),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.image),
            label: Text(
              globals.getText('Import from gallery'),
              style: TextStyle(fontSize: 20),
            ),
            onPressed: _pickImageFromGallery,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF1E6FF),
              minimumSize: Size(double.infinity, 100),
              padding: EdgeInsets.symmetric(horizontal: 20),
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
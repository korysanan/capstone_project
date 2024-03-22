import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'start_image_detection.dart';
import '../globals.dart' as globals;
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
      File imageFile = File(pickedFile.path);
      img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
      img.Image resizedImg = img.copyResize(image, width: 400, height: 300); // 이미지 크기 조정

      // 조정된 이미지를 새 파일에 저장
      String newPath = "${pickedFile.path}_resized.jpg";
      File newImageFile = File(newPath)..writeAsBytesSync(img.encodeJpg(resizedImg));

      setState(() {
        _image = newImageFile;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImageDetailsPage(image: _image!),
        ));
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
      img.Image resizedImg = img.copyResize(image, width: 400, height: 300); // 이미지 크기 조정

      // 조정된 이미지를 새 파일에 저장
      String newPath = "${pickedFile.path}_resized.jpg";
      File newImageFile = File(newPath)..writeAsBytesSync(img.encodeJpg(resizedImg));

      setState(() {
        _image = newImageFile;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImageDetailsPage(image: _image!),
        ));
      });
    }
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
              primary: Colors.green.shade100,
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
              primary: Colors.green.shade100,
              minimumSize: Size(double.infinity, 100),
              padding: EdgeInsets.symmetric(horizontal: 20),
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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'start_image_detection.dart'; // This is the separate file for the ImageDetailsPage.

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
      setState(() {
        _image = File(pickedFile.path);
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
      setState(() {
        _image = File(pickedFile.path);
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
        title: Text('Korean Food Detection'),
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
                      'Image is empty',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Image.file(_image!),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text(
              'Take a Picture',
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
              'Import from gallery',
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
            child: Text('What is Korean Food Detection?'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TransitScreen extends StatelessWidget {
  final Map<String, dynamic> jsonMap;

  TransitScreen({required this.jsonMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transit Data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Transit Data:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(jsonMap.toString(), style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DisplayJsonScreen extends StatelessWidget {
  final Map<String, dynamic> modifiedJsonData;

  DisplayJsonScreen({required this.modifiedJsonData});

  @override
  Widget build(BuildContext context) {
    String modifiedJsonDataString = JsonEncoder.withIndent('  ').convert(modifiedJsonData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Modified JSON Data'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: modifiedJsonDataString));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('JSON copied to clipboard!'))
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          modifiedJsonDataString,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
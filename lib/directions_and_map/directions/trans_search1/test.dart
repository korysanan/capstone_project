import 'dart:convert'; // Add this import
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final Map<String, dynamic> jsonMap;

  TestScreen({required this.jsonMap});

  @override
  Widget build(BuildContext context) {
    String prettyJson = _formatJson(jsonMap);

    return Scaffold(
      appBar: AppBar(
        title: Text('Path Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          prettyJson,
        ),
      ),
    );
  }

  String _formatJson(Map<String, dynamic> json) {
    var encoder = JsonEncoder.withIndent('  '); // Indent with two spaces
    return encoder.convert(json);
  }
}

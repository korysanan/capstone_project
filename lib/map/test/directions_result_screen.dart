import 'dart:convert';

import 'package:flutter/material.dart';

class DirectionsResultScreen extends StatelessWidget {
  final dynamic directions;

  DirectionsResultScreen({required this.directions});


  String _formatJson(Map<String, dynamic> json) {
    var encoder = JsonEncoder.withIndent('  '); // Indent with two spaces
    return encoder.convert(json);
  }

  @override
  Widget build(BuildContext context) {
    String displayText;

    try {
      final route = directions['route']['trafast'][0];
      final summary = route['summary'];
      final startLocation = summary['start']['location'];
      final goalLocation = summary['goal']['location'];
      final distance = summary['distance'];
      final duration = summary['duration'];

      displayText = 'Start: (${startLocation[1]}, ${startLocation[0]})\n'
          'Goal: (${goalLocation[1]}, ${goalLocation[0]})\n'
          'Distance: ${distance}m\n'
          'Duration: ${duration / 1000 / 60} minutes\n';
    } catch (e) {
      displayText = 'Failed to parse directions';
    }

    return Scaffold(
      appBar: AppBar(title: Text('Directions Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(displayText),
      ),
    );
  }
}

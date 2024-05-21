import 'dart:convert';
import 'package:flutter/material.dart';
import 'json_test.dart';
import '../../../globals.dart' as globals;

class TestScreen extends StatelessWidget {
  final Map<String, dynamic> jsonMap;

  TestScreen({required this.jsonMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Movement (1/2)'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...buildPathDetails(context, jsonMap['result']['path']),
          ],
        ),
      ),
    );
  }

  List<Widget> buildPathDetails(BuildContext context, List<dynamic> paths) {
    return paths.map((path) {
      return GestureDetector(
        onTap: () {
          // Handle card tap here
          String formattedJson = _formatJson(path);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JsonDisplayScreen(jsonData: formattedJson),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      globals.getText('Total Time: ') + _formatTotalTime(path['info']['totalTime']),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      globals.getText('Payment: ') + path['info']['totalPayment'].toString() + ' ₩',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                buildBarChart(context, path['subPath']),
                Divider(),
                Text(
                  globals.getText('Departures: ') + path['info']['firstStartStation'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  globals.getText('Arrivals: ') + path['info']['lastEndStation'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.0),
                Text(
                  globals.getText('Route'),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ...buildSubPathDetails(context, path['subPath']),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  String _formatTotalTime(int totalTime) {
    if (totalTime >= 60) {
      int hours = totalTime ~/ 60;
      int minutes = totalTime % 60;
      return hours.toString() + 'hr ' + minutes.toString() + 'min';
    } else {
      return totalTime.toString() + 'min';
    }
  }

  List<Widget> buildSubPathDetails(BuildContext context, List<dynamic> subPaths) {
    return subPaths.map((subPath) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Row(
              children: [
                Icon(
                  _getTrafficIcon(subPath['trafficType']),
                  size: 20,
                  color: _getTrafficIconColor(subPath['trafficType']),
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          subPath['startNameKor'],
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          subPath['startName'],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text("↓"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          subPath['endNameKor'],
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          subPath['endName'],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text(globals.getText('Distance: ') + _formatDistance(subPath['distance'])),
            Text(globals.getText('Duration: ') + subPath['sectionTime'].toString() + 'min'),
          ],
        ),
      );
    }).toList();
  }

  Widget buildBarChart(BuildContext context, List<dynamic> subPaths) {
    double totalSectionTime = subPaths.fold(0, (sum, subPath) => sum + subPath['sectionTime']);
    List<Widget> bars = [];
    double startPosition = 0;

    for (var subPath in subPaths) {
      double percentage = (subPath['sectionTime'] / totalSectionTime);
      Color color = _getTrafficIconColor(subPath['trafficType']);
      bars.add(Positioned(
        left: startPosition,
        child: Container(
          width: percentage * (MediaQuery.of(context).size.width - 64), // Subtracting padding
          height: 10,
          color: color,
        ),
      ));
      startPosition += percentage * (MediaQuery.of(context).size.width - 64);
    }

    return Container(
      width: double.infinity,
      height: 10,
      child: Stack(
        children: bars,
      ),
    );
  }

  String _formatDistance(int distance) {
    if (distance >= 1000) {
      double km = distance / 1000;
      return km.toStringAsFixed(1) + 'km';
    } else {
      return distance.toString() + 'm';
    }
  }

  String _formatJson(Map<String, dynamic> json) {
    var encoder = JsonEncoder.withIndent('  '); // Indent with two spaces
    return encoder.convert(json);
  }

  IconData _getTrafficIcon(int trafficType) {
    switch (trafficType) {
      case 4:
        return Icons.train;
      case 5:
        return Icons.directions_bus;
      case 6:
        return Icons.directions_bus;
      case 7:
        return Icons.airplanemode_active;
      default:
        return Icons.directions_walk;
    }
  }

  Color _getTrafficIconColor(int trafficType) {
    switch (trafficType) {
      case 4:
        return Colors.blue;
      case 5:
        return Colors.green;
      case 6:
        return Colors.orange;
      case 7:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
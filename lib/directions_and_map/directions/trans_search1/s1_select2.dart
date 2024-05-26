import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../globals.dart' as globals;
import 's1_test.dart';
import 's1_test2.dart';

class JsonDisplayScreen extends StatelessWidget {
  final String jsonData;

  JsonDisplayScreen({required this.jsonData});

  @override
  Widget build(BuildContext context) {
    // Parse the JSON data
    Map<String, dynamic> parsedJson = json.decode(jsonData);

    // Extract the first path from cityTransitStart and cityTransitEnd
    if (parsedJson.containsKey('cityTransitStart')) {
      parsedJson['cityTransitStart']['result']['path'] = [
        parsedJson['cityTransitStart']['result']['path'][0]
      ];
    }
    if (parsedJson.containsKey('cityTransitEnd')) {
      parsedJson['cityTransitEnd']['result']['path'] = [
        parsedJson['cityTransitEnd']['result']['path'][0]
      ];
    }

    // Convert the modified JSON back to a string
    String modifiedJsonDataString = json.encode(parsedJson);
    Map<String, dynamic> modifiedJsonData = json.decode(modifiedJsonDataString);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Movement (2/2)'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _showConfirmationDialog(context, modifiedJsonData);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...buildPathCards1(context, modifiedJsonData['cityTransitStart']['result']['path'], modifiedJsonData['interCityTransit']['info']['firstStartStation']),
                  if (modifiedJsonData.containsKey('interCityTransit')) ...[
                    Text(
                      '${modifiedJsonData['interCityTransit']['info']['firstStartStation']} -> ${modifiedJsonData['interCityTransit']['info']['lastEndStation']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                  ],
                  ...buildPathCards2(context, modifiedJsonData['cityTransitEnd']['result']['path'], modifiedJsonData['interCityTransit']['info']['lastEndStation']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Map<String, dynamic> modifiedJsonData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you want to display the modified JSON data?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToDisplayJsonScreen(context, modifiedJsonData);
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToDisplayJsonScreen(BuildContext context, Map<String, dynamic> modifiedJsonData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        //builder: (context) => DisplayJsonScreen(modifiedJsonData: modifiedJsonData),
        builder: (context) => WebViewScreen(modifiedJsonData: modifiedJsonData),
      ),
    );
  }

  List<Widget> buildPathCards1(BuildContext context, List<dynamic> paths, String fs) {
    return paths.map((path) {
      return InkWell(
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
                    Row(
                      children: [
                        Text(
                          globals.getText('Total Time: '),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_formatTotalTime(path['info']['totalTime'])}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          globals.getText('Payment: '),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '${path['info']['payment']} ₩',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                buildBarChart(context, path['subPath']),
                Divider(),
                Row(
                  children: [
                    Text(
                      globals.getText('Departures: '),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8),
                    Text(
                      globals.getText('Current Location'),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      globals.getText('Arrivals: '),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        fs,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
  
  List<Widget> buildPathCards2(BuildContext context, List<dynamic> paths, String le) {
    return paths.map((path) {
      return InkWell(
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
                    Row(
                      children: [
                        Text(
                          globals.getText('Total Time: '),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_formatTotalTime(path['info']['totalTime'])}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          globals.getText('Payment: '),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '${path['info']['payment']} ₩',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                buildBarChart(context, path['subPath']),
                Divider(),
                Row(
                  children: [
                    Text(
                      globals.getText('Departures: '),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8),
                    Text(
                      le,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      globals.getText('Arrivals: '),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        globals.arr_restaurantName ?? 'Default Name',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
      return '${hours}hr ${minutes}min';
    } else {
      return '${totalTime}min';
    }
  }

  List<Widget> buildSubPathDetails(BuildContext context, List<dynamic> subPaths) {
    return subPaths.where((subPath) => subPath['trafficType'] != 3).map((subPath) {
      Color textColor = _getTrafficIconColor(subPath);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  _getTrafficIcon(subPath['trafficType']),
                  size: 20,
                  color: textColor,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: _getTrafficType(subPath['trafficType']),
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                        TextSpan(
                          text: _getLaneInfo(subPath['lane']),
                          style: TextStyle(fontSize: 12, color: textColor),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  globals.getText('Distance: '),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${_formatDistance(subPath['distance'])}',
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  globals.getText('Duration: '),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${subPath['sectionTime']}min',
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  globals.getText('Departures: '),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${subPath['startNameKor']} (${subPath['startName']})',
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  globals.getText('Arrivals: '),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${subPath['endNameKor']} (${subPath['endName']})',
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Color _getTrafficIconColor(dynamic subPath) {
    if (subPath['trafficType'] == 1 && subPath.containsKey('lane') && subPath['lane'].isNotEmpty) {
      return _getSubwayColor(subPath['lane'][0]['subwayCode']);
    } else if (subPath['trafficType'] == 2) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  String _getLaneInfo(List<dynamic>? lanes) {
    if (lanes == null || lanes.isEmpty) {
      return '';
    }
    final lane = lanes[0];
    if (lane.containsKey('busNo')) {
      return ' (${lane['busNo']})';
    } else if (lane.containsKey('name')) {
      return ' (${lane['name']})';
    }
    return '';
  }

  Widget buildBarChart(BuildContext context, List<dynamic> subPaths) {
    double totalSectionTime = subPaths.fold(0, (sum, subPath) => sum + subPath['sectionTime']);
    List<Widget> bars = [];
    double startPosition = 0;

    for (var subPath in subPaths) {
      double percentage = (subPath['sectionTime'] / totalSectionTime);
      Color color;
      if (subPath['trafficType'] == 1 && subPath.containsKey('lane') && subPath['lane'].isNotEmpty) {
        color = _getSubwayColor(subPath['lane'][0]['subwayCode']);
      } else if (subPath['trafficType'] == 2) {
        color = Colors.red;
      } else if (subPath['trafficType'] == 3) {
        color = Colors.grey;
      } else {
        color = Colors.black;
      }
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

  Color _getSubwayColor(int subwayCode) {
    switch (subwayCode) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.lightBlue;
      case 5:
        return Colors.purple;
      case 6:
        return Colors.brown;
      case 7:
        return Colors.lightGreen;
      case 8:
        return Colors.pink;
      case 9:
        return Colors.yellow;
      default:
        return Colors.red.shade200;
    }
  }

  String _formatDistance(int distance) {
    if (distance >= 1000) {
      double km = distance / 1000;
      return '${km.toStringAsFixed(1)}km';
    } else {
      return '${distance}m';
    }
  }

  IconData _getTrafficIcon(int trafficType) {
    switch (trafficType) {
      case 1:
        return Icons.directions_subway;
      case 2:
        return Icons.directions_bus;
      default:
        return Icons.directions_walk;
    }
  }

  String _getTrafficType(int trafficType) {
    switch (trafficType) {
      case 1:
        return globals.getText('Subway');
      case 2:
        return globals.getText('Bus');
      case 3:
        return globals.getText('Walking');
      default:
        return globals.getText('Etc');
    }
  }
}

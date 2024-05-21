import 'package:flutter/material.dart';

import '../../../home/bottom.dart';
import '../../../home/on_item_tap.dart';
import 'trans_0_path.dart';
import '../../../globals.dart' as globals;

// ignore: must_be_immutable
class TransitScreen0 extends StatelessWidget {
  final Map<String, dynamic> jsonMap;

  TransitScreen0({required this.jsonMap});
  
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(globals.getText('Select Movement')),
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
            ...buildPathCards(context, jsonMap['result']['path']),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }

  List<Widget> buildPathCards(BuildContext context, List<dynamic> paths) {
    return paths.map((path) {
      return InkWell(
        onTap: () {
          // Create jsonMap2
          Map<String, dynamic> jsonMap2 = {
            "result": {
              "searchType": jsonMap['result']['searchType'],
              "outTrafficCheck": jsonMap['result']['outTrafficCheck'],
              "busCount": jsonMap['result']['busCount'],
              "subwayCount": jsonMap['result']['subwayCount'],
              "subwayBusCount": jsonMap['result']['subwayBusCount'],
              "pointDistance": jsonMap['result']['pointDistance'],
              "startRadius": jsonMap['result']['startRadius'],
              "endRadius": jsonMap['result']['endRadius'],
              "path": [path] // Only the clicked path
            }
          };

          // Navigate to PathDetailScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PathDetailScreen(jsonMap2: jsonMap2),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${path['info']['firstStartStationKor']}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '(${path['info']['firstStartStation']})',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${path['info']['lastEndStationKor']}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '(${path['info']['lastEndStation']})',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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

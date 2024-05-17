import 'package:flutter/material.dart';

class TransitScreen extends StatelessWidget {
  final Map<String, dynamic> jsonMap;

  TransitScreen({required this.jsonMap});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Movement'),
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
    );
  }

  List<Widget> buildPathCards(BuildContext context, List<dynamic> paths) {
    return paths.map((path) {
      return InkWell(
        onTap: () {
          // Handle tap event here
          print('Card tapped with path info: ${path['info']}');
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
                      'Total Time: ${_formatTotalTime(path['info']['totalTime'])}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Payment: ${path['info']['payment']} ₩',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                buildBarChart(context, path['subPath']),
                Divider(),
                Text(
                  'Departures : ${path['info']['firstStartStation']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Arrivals : ${path['info']['lastEndStation']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Route',
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
                Text.rich(
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
                ),
              ],
            ),
            Text('Distance: ${_formatDistance(subPath['distance'])}'),
            Text('Duration of time: ${subPath['sectionTime']}min'),
            Text('Departures: ${subPath['startName']}'),
            Text('Arrivals: ${subPath['endName']}'),
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
        return 'Subway';
      case 2:
        return 'Bus';
      case 3:
        return 'Walking';
      default:
        return 'Etc';
    }
  }
}

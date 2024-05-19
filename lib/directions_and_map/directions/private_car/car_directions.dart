import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart'; // Add this import
import '../../../globals.dart' as globals;

class DirectionsResultScreen extends StatelessWidget {
  final dynamic directions;

  DirectionsResultScreen({required this.directions});

  String calculateArrivalTime(String durationText, String departureTime) {
    // Parse durationText
    final RegExp durationRegex = RegExp(r'(\d+)h (\d+)m');
    final RegExp minutesRegex = RegExp(r'(\d+) minutes');
    int totalMinutes = 0;

    if (durationRegex.hasMatch(durationText)) {
      final match = durationRegex.firstMatch(durationText)!;
      final hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      totalMinutes = (hours * 60) + minutes;
    } else if (minutesRegex.hasMatch(durationText)) {
      final match = minutesRegex.firstMatch(durationText)!;
      totalMinutes = int.parse(match.group(1)!);
    }

    // Parse departureTime
    final DateTime departureDateTime = DateTime.parse(departureTime);

    // Calculate arrival time
    final DateTime arrivalDateTime = departureDateTime.add(Duration(minutes: totalMinutes));

    // Format arrival time
    final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return dateFormat.format(arrivalDateTime);
  }

  @override
  Widget build(BuildContext context) {
    String displayTextTop;
    String displayTextBottom;

    try {
      final route = directions['route']['trafast'][0];
      final summary = route['summary'];
      final distance = summary['distance'];
      final duration = summary['duration'];
      final departureTime = summary['departureTime'];
      final tollFare = summary['tollFare'];
      final taxiFare = summary['taxiFare'];
      final fuelPrice = summary['fuelPrice'];

      String distanceText = distance >= 1000
          ? '${(distance / 1000).toStringAsFixed(2)} km'
          : '$distance m';

      String durationText = duration >= 3600000
          ? '${(duration ~/ 3600000)}h ${(duration % 3600000) ~/ 60000}m'
          : '${(duration / 60000).toStringAsFixed(0)} minutes';

      String arrivalTime = calculateArrivalTime(durationText, departureTime);

      displayTextTop =
          'Starting point: 현재 위치\n'
          'Destination restaurant: ${globals.arr_restaurantName}';

      displayTextBottom =
          'Distance: $distanceText\n'
          'Duration: $durationText\n'
          'Departure Time: $departureTime\n'
          'Arrival Time: $arrivalTime\n'
          'Toll Fare: ${tollFare} ₩\n'
          'Taxi Fare: ${taxiFare} ₩\n'
          'Fuel Price: ${fuelPrice} ₩';
    } catch (e) {
      displayTextTop = 'Starting point: 현재 위치\nDestination restaurant: ${globals.arr_restaurantName}\n';
      displayTextBottom = 'Failed to parse directions';
    }

    final GlobalKey contentKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(title: Text('Directions Result')),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://www.google.com/maps', // Replace with your desired URL
            javascriptMode: JavascriptMode.unrestricted,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrollController) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, -2),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Card(
                                key: contentKey,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayTextTop,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Divider(),
                                      Text(
                                        displayTextBottom,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

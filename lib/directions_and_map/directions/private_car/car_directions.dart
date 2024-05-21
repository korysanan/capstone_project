import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart'; // Add this import
import '../../../globals.dart' as globals;
import '../../../home/bottom.dart';
import '../../../home/on_item_tap.dart';

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
    int _currentIndex = 0;

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

      final String departureLabel = globals.getText('Departures: ');
      final String arrivalLabel = globals.getText('Arrivals: ');

      displayTextTop =
          'Starting point: 현재 위치\n'
          'Destination restaurant: ${globals.arr_restaurantName}';

      final String distanceLabel = globals.getText('Distance: ');
      final String distanceValue = '$distanceText\n';
      final String durationLabel = globals.getText('Duration: ');
      final String durationValue = '$durationText\n';
      final String departureTimeLabel = globals.getText('Departure Time: ');
      final String departureTimeValue = '$departureTime\n';
      final String arrivalTimeLabel = globals.getText('Arrival Time: ');
      final String arrivalTimeValue = '$arrivalTime\n';
      final String tollFareLabel = globals.getText('Toll Fare: ');
      final String tollFareValue = '${tollFare} ₩\n';
      final String taxiFareLabel = globals.getText('Taxi Fare: ');
      final String taxiFareValue = '${taxiFare} ₩\n';
      final String fuelPriceLabel = globals.getText('Fuel Price: ');
      final String fuelPriceValue = '${fuelPrice} ₩';

      displayTextBottom = 
        '$distanceLabel $distanceValue'
        '$durationLabel $durationValue'
        '$departureTimeLabel $departureTimeValue'
        '$arrivalTimeLabel $arrivalTimeValue'
        '$tollFareLabel $tollFareValue'
        '$taxiFareLabel $taxiFareValue'
        '$fuelPriceLabel $fuelPriceValue';

    } catch (e) {
      displayTextTop = 'Starting point: 현재 위치\nDestination restaurant: ${globals.arr_restaurantName}\n';
      displayTextBottom = 'Failed to parse directions';
    }

    final GlobalKey contentKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(title: Text(globals.getText('Directions Result'))),
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
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}

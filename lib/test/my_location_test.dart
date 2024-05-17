import 'package:flutter/material.dart';
import '../directions_and_map/my_location/my_location_service.dart';
import '../globals.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _locationMessage = "";

  void _updateLocation() async {
    await LocationService.getCurrentLocation();
    setState(() {
      _locationMessage = "Lat: ${globals.my_latitude}, Long: ${globals.my_longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_locationMessage),
            ElevatedButton(
              onPressed: _updateLocation,
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
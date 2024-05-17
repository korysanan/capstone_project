import 'package:flutter/material.dart';
import 'odsay_api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _result = 'Press the button to fetch data';

  void _fetchData() async {
    // Replace {YOUR_API_KEY} with your actual ODsay API key
    String result = await ApiService.fetchBusData();
    setState(() {
      _result = result;
    });
    print(result); // Print the result to the console
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Request Example'),
      ),
      body: SingleChildScrollView( // Make the body scrollable
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _fetchData,
                child: Text('Fetch Bus Data'),
              ),
              SizedBox(height: 20),
              Text(_result,
                  textAlign: TextAlign.center), // Ensure text is centered
            ],
          ),
        ),
      ),
    );
  }
}
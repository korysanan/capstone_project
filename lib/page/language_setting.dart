import 'package:flutter/material.dart';
import '../home/bottom.dart';

class LanguageSelectScreen extends StatefulWidget {
  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  int _currentIndex = 0; // bottom navigation index number

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Map<String, dynamic>> languages = [
    {'name': 'Korean', 'flag': '🇰🇷'},
    {'name': 'English', 'flag': '🇺🇸'},
    {'name': 'Chinese', 'flag': '🇨🇳'},
    {'name': 'German', 'flag': '🇩🇪'},
    {'name': 'Spanish', 'flag': '🇪🇸'},
    {'name': 'Japanese', 'flag': '🇯🇵'},
    {'name': 'Portuguese', 'flag': '🇵🇹'},
    {'name': 'Hindi', 'flag': '🇮🇳'},
    {'name': 'Dutch', 'flag': '🇳🇱'},
    {'name': 'French', 'flag': '🇫🇷'},
    {'name': 'Russian', 'flag': '🇷🇺'},
    {'name': 'Turkish', 'flag': '🇹🇷'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          var language = languages[index]['name'];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(languages[index]['flag']),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                language,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // This is where you add the print statement
                print('Selected language: $language');
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'naver_search_service.dart';

class SearchScreen extends StatefulWidget {
  final NaverSearchService searchService;

  SearchScreen({Key? key, required this.searchService}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _results = [];

  void _search() async {
    try {
      var result = await widget.searchService.searchLocal(query: _controller.text);
      setState(() {
        _results = result['items'];
      });
    } catch (e) {
      print(e);
      // Handle errors or no data scenario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Naver Local Search')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_results[index]['title']),
                  subtitle: Text(_results[index]['address']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

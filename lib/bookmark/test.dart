/*
import 'package:flutter/material.dart';
import 'bookmark_service.dart';
import 'bookmark_data.dart'; // BookmarkData 클래스를 import

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _bookmarksInfo = "No bookmarks fetched yet";

  void _handleFetchBookmarks() async {
    await BookmarkService.fetchBookmarks(); // 북마크 데이터를 서버로부터 불러옴
    setState(() {
      _bookmarksInfo = "Bookmarks fetched: ${BookmarkData.getBookmarkNames()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Bookmarks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _bookmarksInfo,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleFetchBookmarks,
              child: Text('Fetch Bookmarks'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
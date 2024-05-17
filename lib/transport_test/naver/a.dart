import 'package:flutter/material.dart';
import 'naver_search_service.dart';
import 'food_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // API 사용을 위한 Client ID와 Client Secret
  final String clientId = 'UL2ZwKo4PjmnnOHuyM0g';
  final String clientSecret = 'J9R2nT8c1b';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naver API Search Demo',
      home: SearchScreen(
        searchService: NaverSearchService(clientId: clientId, clientSecret: clientSecret),
      ),
    );
  }
}

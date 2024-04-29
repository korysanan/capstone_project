import '../db/communityPost.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final List<CommunityPost> posts;
  String searchText = '';

  PostList({
    super.key,
    required this.posts,
    searchText,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

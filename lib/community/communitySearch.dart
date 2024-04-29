import '../home/appbar.dart';
import 'package:flutter/material.dart';

class CommunitySearch extends StatefulWidget {
  const CommunitySearch({super.key});

  @override
  State<CommunitySearch> createState() => _CommunitySearchState();
}

class _CommunitySearchState extends State<CommunitySearch> {
  String inputText = '';
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar: const BasicAppBar(title: 'Community Search'),
        body: Align(
          alignment: Alignment.topCenter,
          child: SearchBar(
            focusNode: focusNode,
            trailing: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  FocusManager.instance.primaryFocus
                      ?.unfocus(); // 검색 아이콘 누르면 키보드 숨김
                },
              ),
            ],
            backgroundColor: const MaterialStatePropertyAll(
              Color(0xFFC9C9C9),
            ),
            shadowColor: const MaterialStatePropertyAll(Colors.black),
            overlayColor: const MaterialStatePropertyAll(Color(0XFFAAAAAA)),
            constraints: const BoxConstraints(
              maxWidth: 350.0,
              minHeight: 55.0,
            ),
            shape: MaterialStateProperty.all(
              ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
            hintText: "검색어를 입력하세요",
            onChanged: (value) {
              setState(() => inputText = value); // 입력값 inputText로 실시간 저장
            },
          ),
        ),
      ),
    );
  }
}

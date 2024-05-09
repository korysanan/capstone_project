import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNav({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  BottomNavigationBarItem _bottomNavigationBarItem(String iconName, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset("assets/svg/${iconName}_off.svg", width: 22),
      ),
      label: '',
    );
  }
  // svg 파일 이용해서 아이콘 생성함. 

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 117, 201, 243),
      type: BottomNavigationBarType.fixed,
      onTap: widget.onTap,
      selectedFontSize: 1,
      currentIndex: widget.currentIndex,
      items: [
        _bottomNavigationBarItem("home", "Home"),
        _bottomNavigationBarItem("search", "Search"),
        _bottomNavigationBarItem("chatbot", "Chatbot"),
        _bottomNavigationBarItem("mypage", "Mypage"),
      ],
    );
  }
}

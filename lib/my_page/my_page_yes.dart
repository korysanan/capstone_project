import 'package:flutter/material.dart';
import 'language_setting.dart';
import '../home/bottom.dart';
import 'user_info.dart';

class MyPageYes extends StatefulWidget {
  @override
  _MyPageYesState createState() => _MyPageYesState();
}

class _MyPageYesState extends State<MyPageYes> {
  int _currentIndex = 0; // bottomnavigation index 번호 

  Map<String, List<String>> items = {
    'Community/Custom Recipes': ['Article title 1', 'Article title 2', 'Article title 1', 'Article title 2'],
    'Food Images': ['Water Kimchi', 'Bulgogi', 'food 2', 'food 3'],
  };
  // 일단 북마크 했다고 가정하고 임시 자료

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  // 아이콘 눌렀을때 인덱스 번호 설정 
  // home = 0, mail = 1, camera = 2, search = 3 , chatbot = 4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 위치 고정하는거 -> 이거 x일시 만약 키보드 올라올때 각각들도 따라 올라옴 
      appBar: AppBar(
        title: Text('MyPage'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguageSelectScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Icon(Icons.bookmark),
                InkWell( // Text를 InkWell로 감싸 클릭 가능하게
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserInfoScreen()),
                    );
                  },
                  child: Text(
                    'abcd@gmail.com',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    // 로그아웃 기능 추가
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.bookmark),
                SizedBox(width: 8),
                Text(
                  'bookmark list',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...items.entries.map((entry) => _buildExpansionTile(title: entry.key, children: entry.value)).toList(),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      // lib/home/bottom.dart에서 bottomNavigation 불러오기 
    );
  }

  Widget _buildExpansionTile({required String title, required List<String> children}) {
    return ExpansionTile(
      title: Text(title),
      children: children.map((String item) {
        return ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteItem(title, item),
          ),
        );
      }).toList(),
    );
  }

  void _deleteItem(String category, String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete it?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  items[category]?.remove(item);
                  if (items[category]?.isEmpty ?? true) {
                    items.remove(category);
                  }
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
}

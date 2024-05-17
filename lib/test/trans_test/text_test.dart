import 'package:flutter/material.dart';
import '../../translate/language_detect.dart'; // Ensure this import is correctly pointing to your trans.dart file location

class TextTest extends StatefulWidget {
  @override
  _TextTestState createState() => _TextTestState();
}

class _TextTestState extends State<TextTest> {
  String displayText = 'Tteokbokkitteok (thin rice cake sticks) stir-fried in a spicy gochujang (red chili paste) sauce with vegetables and fish cakes and cooked at the table. Dumplings, jjolmyeon (chewy noodle), hard-boiled eggs, and cheese may be added as well.';
  String displayText2 = '薄年糕条（Tteokbokkitteok）用辣味五香酱（红辣椒酱）与蔬菜和鱼糕一起炒，在餐桌上烹制。还可以添加饺子、嚼面、煮鸡蛋和奶酪。';
  String displayText3 = 'Tteokbokkitteok (bolinhos de arroz finos) fritos num molho picante de gochujang (pasta de pimentão vermelho) com legumes e bolinhos de peixe e cozinhados à mesa. Também podem ser adicionados bolinhos de massa, jjolmyeon (massa elástica), ovos cozidos e queijo.';

  Future<void> _translateText() async {
    try {
      String translatedText = await translateText(displayText);
      String translatedText2 = await translateText(displayText2);
      String translatedText3 = await translateText(displayText3);
      setState(() {
        displayText = translatedText;
        displayText2 = translatedText2;
        displayText3 = translatedText3;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to translate text. Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextTransTest'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(displayText),
            SizedBox(height: 20),
            Text(displayText2),
            SizedBox(height: 20),
            Text(displayText3),
            ElevatedButton(
              onPressed: _translateText,
              child: Text('Translate'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../translate/language_detect.dart';

class TranslationPage2 extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage2> {
  final TextEditingController _controller = TextEditingController();
  String _translation = '';

  void _translate() async {
    final text = _controller.text;
    if (text.isNotEmpty) {
      final translatedText = await translateText(text);
      setState(() {
        _translation = translatedText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate to English'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter text to translate',
              ),
            ),
            ElevatedButton(
              onPressed: _translate,
              child: Text('Translate'),
            ),
            SizedBox(height: 20),
            Text(
              _translation,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

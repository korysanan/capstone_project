import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome to K-Food Box!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
        ),
        SizedBox(height: 32.0),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/ex/korea_door.png",
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: 32.0),
      ],
    );
  }
}
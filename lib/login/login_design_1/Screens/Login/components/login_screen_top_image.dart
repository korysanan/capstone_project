import 'package:flutter/material.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset("assets/ex/kfood_logo.png"),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

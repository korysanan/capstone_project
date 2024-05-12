import 'package:flutter/material.dart';
import '../translate/language_detect.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CategoryAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
        iconSize: 40,
      ),
      title: FutureBuilder<String>(
        future: translateText(title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text(
                'Error',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              );
            } else {
              return Text(
                snapshot.data ?? 'Translation error', // 번역 실패시 대체 텍스트
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
          } else {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      centerTitle: true,
      actions: [
        InkWell(
          child: Image.asset('assets/ex/kfood_logo.png'),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

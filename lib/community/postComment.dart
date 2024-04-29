import 'package:flutter/material.dart';

class PostComments extends StatefulWidget {
  List<dynamic>? comments;
  PostComments({required this.comments, super.key});

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  @override
  Widget build(BuildContext context) {
    print('called');
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 2),
        itemCount: widget.comments?.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${widget.comments?[index].nickname}   ',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.comments?[index].createdAt,
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xff808080)),
                  ),
                ],
              ),
              Text(
                widget.comments?[index].content,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                width: 500,
                height: 15,
                child: Divider(color: Color(0xff808080), thickness: 1.0),
              ),
            ],
          );
        });
  }
}

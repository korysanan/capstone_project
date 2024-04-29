import 'dart:io';
import 'postAppbar.dart';
import '../db/communityPost.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class CommunityPosting extends StatefulWidget {
  const CommunityPosting({super.key});

  @override
  State<CommunityPosting> createState() => _CommunityPostingState();
}

class _CommunityPostingState extends State<CommunityPosting> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final picker = ImagePicker();
  final focusNode = FocusNode();
  String inputTitle = '';
  String inputContent = '';

  XFile? image;
  List<XFile?> multiImage = [];
  List<XFile?> images = [];

  Future<dynamic> showdialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('The maximum number of images is 10'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar: CommunityPostAppBar(title: "Writing", images: images),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter your title',
                ),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                ),
                controller: titleController,
                onChanged: (value) {
                  setState(() => inputTitle = value);
                },
              ),
              const SizedBox(
                width: 500,
                child: Divider(color: Colors.black, thickness: 2.0),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your contents',
                ),
                maxLines: 20,
                style: const TextStyle(
                  fontSize: 18,
                ),
                keyboardType: TextInputType.multiline,
                controller: bodyController,
                onChanged: (value) {
                  setState(() => inputContent = value);
                },
              ),
              const SizedBox(
                width: 500,
                child: Divider(color: Colors.black, thickness: 2.0),
              ),
              Container(
                width: 350,
                height: 50,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5)
                  ],
                ),
                child: TextButton.icon(
                  label: const Text(
                    "Add photo...",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    multiImage = await picker.pickMultiImage();
                    if (images.length + multiImage.length > 10) {
                      showdialog(context);
                      multiImage.clear();
                    }
                    setState(() {
                      images.addAll(multiImage);
                    });
                  },
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 10 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(images[index]!.path),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            images[index]!.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.close,
                                  color: Colors.white, size: 15),
                              onPressed: () {
                                setState(() {
                                  images.remove(images[index]);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

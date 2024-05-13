import 'dart:collection';
import 'dart:io';
import 'postAppbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../globals.dart' as globals;

class CommunityPosting extends StatefulWidget {
  const CommunityPosting({
    super.key,
  });

  @override
  State<CommunityPosting> createState() => _CommunityPostingState();
}

class _CommunityPostingState extends State<CommunityPosting> {
  late final titleController = TextEditingController();
  late final bodyController = TextEditingController();
  late final ingredientController = <TextEditingController>[];
  late final quantityController = <TextEditingController>[];
  late final sequenceController = <TextEditingController>[];
  List<Map<String, dynamic>> savedIngredients = [];
  final List<XFile?> _imageFiles = [];
  List<Map<String, dynamic>> inputSequence = [];

  String inputTitle = '';
  String inputContent = '';
  final picker = ImagePicker();
  final focusNode = FocusNode();

  List<XFile> multiImage = [];
  List<XFile> images = [];

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

  void _updateSavedIngredients() {
    setState(() {
      savedIngredients.clear();
      for (var i = 0; i < ingredientController.length; i += 2) {
        savedIngredients.add({
          'name': ingredientController[i].text,
          'quantity': ingredientController[i + 1].text,
        });
      }
    });
  }

  Future<void> _getImage(int index) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFiles[index] = pickedFile;
      });
      _updateSavedRecipe(index, sequenceController[index].text);
    }
  }

  void _updateSavedRecipe(int index, String text) {
    setState(() {
      if (index < sequenceController.length) {
        sequenceController[index].text = text;
        inputSequence[index] = {
          'sequenceNumber': index + 1,
          'content': text,
          'imageUrl': _imageFiles[index]
        };
      }
    });
  }

  void _deleteRecipe(int index) {
    setState(() {
      sequenceController.removeAt(index);
      _imageFiles.removeAt(index);
      inputSequence.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Scaffold(
          appBar: RecipePostAppBar(
            title: 'Writing',
            inputTitle: inputTitle,
            inputContent: inputContent,
            images: images,
            savedIngredients: savedIngredients,
            inputSequence: inputSequence,
          ),
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
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your contents',
                  ),
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.multiline,
                  controller: bodyController,
                  onChanged: (value) {
                    setState(() => inputContent = value);
                  },
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
                          color: const Color(0xFF0277BD).withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: TextButton.icon(
                    label: const Text(
                      'Add photo',
                      style: TextStyle(
                        color: Color(0xFF303F9F),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    File(images[index].path),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              images[index].name,
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
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(color: Color(0xFF1565C0), thickness: 1.0),
                ),
                // 재료 추가
                if (ingredientController.isNotEmpty)
                  const Row(
                    children: [
                      Text('Ingredient'),
                      SizedBox(width: 100),
                      Text('Quantity'),
                    ],
                  ),
                Column(
                  children:
                      List.generate(ingredientController.length ~/ 2, (index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: ingredientController[index * 2],
                              onChanged: (text) => _updateSavedIngredients(),
                              decoration: const InputDecoration(
                                hintText: "",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: ingredientController[index * 2 + 1],
                              onChanged: (text) => _updateSavedIngredients(),
                              decoration: const InputDecoration(
                                hintText: "",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              ingredientController.removeAt(index * 2 + 1);
                              ingredientController.removeAt(index * 2);
                            });
                          },
                        ),
                      ],
                    );
                  }),
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
                          color: const Color(0xFF0277BD).withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: TextButton.icon(
                    label: const Text(
                      'Add ingredient',
                      style: TextStyle(
                        color: Color(0xFF303F9F),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        ingredientController.add(TextEditingController());
                        ingredientController.add(TextEditingController());
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(color: Color(0xFF1565C0), thickness: 1.0),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: sequenceController.length,
                  itemBuilder: (context, index) {
                    final isLastItem = index == sequenceController.length - 1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: sequenceController[index],
                                onChanged: (text) {
                                  _updateSavedRecipe(index, text);
                                },
                                decoration: InputDecoration(
                                    labelText: 'Recipe sequence ${index + 1}'),
                              ),
                            ),
                            if (isLastItem)
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteRecipe(index);
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        _imageFiles[index] == null
                            ? ElevatedButton(
                                onPressed: () {
                                  _getImage(index);
                                },
                                child:
                                    Text('Add Image for Recipe ${index + 1}'),
                              )
                            : Image.file(
                                File(_imageFiles[index]!.path),
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                        const SizedBox(height: 20.0),
                      ],
                    );
                  },
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
                          color: const Color(0xFF0277BD).withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: TextButton.icon(
                    label: const Text(
                      'Add sequence',
                      style: TextStyle(
                        color: Color(0xFF303F9F),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        sequenceController.add(TextEditingController());
                        _imageFiles.add(null);
                        inputSequence.add({
                          'sequenceNumber': sequenceController.length + 1,
                          'content': sequenceController.last.text,
                          'imageUrl': null
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

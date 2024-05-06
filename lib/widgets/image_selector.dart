import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({super.key, required this.onImagePicked});

  final void Function(File file) onImagePicked;

  @override
  State<StatefulWidget> createState() {
    return _ImageSelectorState();
  }
}

class _ImageSelectorState extends State<ImageSelector> {
  final ImagePicker picker = ImagePicker();

  File? image;

  _pickImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage == null) {
      return;
    }

    var pickedImageFile = File(pickedImage.path);

    setState(() {
      image = pickedImageFile;
    });

    widget.onImagePicked(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return image != null
        ? GestureDetector(
            onTap: _pickImage,
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.file(
                image!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(150),
              ),
            ),
            child: TextButton(
              onPressed: _pickImage,
              child: const Text("Pick Image"),
            ),
          );
  }
}

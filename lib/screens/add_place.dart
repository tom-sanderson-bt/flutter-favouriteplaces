import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _image;

  _savePlace() {
    var enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _image == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(
          Place(title: enteredTitle, image: _image!),
        );
    Navigator.of(context).pop();
  }

  _onImagePicked(File image) {
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text("Title"),
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            ImageSelector(onImagePicked: _onImagePicked),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _savePlace,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

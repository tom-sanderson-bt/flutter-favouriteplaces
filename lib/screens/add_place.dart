import 'dart:io';

import 'package:favourite_places/models/location.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_selector.dart';
import 'package:favourite_places/widgets/location_picker.dart';
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
  Location? _location;

  _savePlace() {
    var enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _image == null || _location == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _image!, _location!);

    Navigator.of(context).pop();
  }

  _onImagePicked(File image) {
    _image = image;
  }

  _onLocationPicked(Location location) {
    _location = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePlace,
          ),
        ],
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
            LocationPicker(onLocationPicked: _onLocationPicked),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/favourite_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  final TextEditingController _titleController = TextEditingController();

  _addFavouritePlace() {
    ref.read(favouritePlacesProvider.notifier).addFavouritePlace(
          Place(
            name: _titleController.value.text,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add favourite place"),
      ),
      body: Padding(
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
            ElevatedButton(
              onPressed: _addFavouritePlace,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

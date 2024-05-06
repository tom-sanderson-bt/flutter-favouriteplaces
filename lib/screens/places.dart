import 'package:favourite_places/providers/favourite_places.dart';
import 'package:favourite_places/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(favouritePlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Great Places"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const AddPlacesScreen();
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(items[i].name),
        ),
      ),
    );
  }
}

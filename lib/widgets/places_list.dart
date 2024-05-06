import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(userPlacesProvider);

    if (items.isEmpty) {
      return const Center(
        child: Text('No places added yet'),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) => ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return PlaceDetails(place: items[i]);
              },
            ),
          );
        },
        title: Text(items[i].title),
      ),
    );
  }
}

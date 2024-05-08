import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var userPlacesNotifier = UserPlacesNotifier();

class PlacesList extends ConsumerStatefulWidget {
  const PlacesList({super.key});

  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {
  late final Future<void> _futurePlaces;

  @override
  void initState() {
    super.initState();

    _futurePlaces = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    var items = ref.watch(userPlacesProvider);

    if (items.isEmpty) {
      return const Center(
        child: Text('No places added yet'),
      );
    }

    return FutureBuilder(
        future: _futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) => ListTile(
              contentPadding: const EdgeInsets.all(6),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return PlaceDetails(place: items[i]);
                    },
                  ),
                );
              },
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(items[i].image),
              ),
              title: Text(items[i].title),
            ),
          );
        });
  }
}

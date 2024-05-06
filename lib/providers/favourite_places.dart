import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePlacesNotifier extends StateNotifier<List<Place>> {
  FavouritePlacesNotifier() : super([]);

  addFavouritePlace(Place place) {
    state = [...state, place];
  }
}

final favouritePlacesProvider =
    StateNotifierProvider<FavouritePlacesNotifier, List<Place>>(
        (ref) => FavouritePlacesNotifier());

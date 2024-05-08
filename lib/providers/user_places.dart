import 'dart:io';

import 'package:favourite_places/models/location.dart';
import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT) ');
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    try {
      final data = await db.query('user_places');
      var places = data
          .map(
            (row) => Place(
              title: row['title'] as String,
              image: File(row['image'] as String),
              location: Location(
                lat: row['lat'] as double,
                lng: row['lng'] as double,
                address: row['address'] as String,
              ),
            ),
          )
          .toList();

      state = places;
    } catch (exc) {
      print(exc);
      // unable to load
    }
  }

  addPlace(String title, File image, Location location) async {
    final directory = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final newImage = await image.copy(path.join(directory.path, filename));

    final place = Place(title: title, location: location, image: newImage);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': place.location.lat,
      'lng': place.location.lng,
      'address': place.location.address,
    });

    state = [...state, place];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/maps.dart';
import 'package:favourite_places/services/static_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black45]),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (contxt) {
                        return MapScreen(
                          isSelecting: false,
                          location:
                              LatLng(place.location.lat, place.location.lng),
                        );
                      }));
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        StaticMapService.getStaticMap(
                            place.location.lat, place.location.lng),
                      ),
                    ),
                  ),
                  Text(
                    place.location.address,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

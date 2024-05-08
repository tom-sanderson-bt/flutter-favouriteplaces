import 'dart:convert';

import 'package:favourite_places/models/location.dart';
import 'package:favourite_places/screens/maps.dart';
import 'package:favourite_places/secrets.dart';
import 'package:favourite_places/services/location.dart';
import 'package:favourite_places/services/static_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key, required this.onLocationPicked});

  final void Function(Location location) onLocationPicked;

  @override
  State<StatefulWidget> createState() {
    return _LocationPickerState();
  }
}

class _LocationPickerState extends State<LocationPicker> {
  Location? _location;
  bool _isLoading = false;

  _getLocation() async {
    print('getLocation');
    Position? position;
    // try {
    setState(() {
      _isLoading = true;
    });
    position = await LocationService.determinePosition();
    setState(() {
      _isLoading = false;
    });
    print('position returned $position');

    /* } catch (exc) {
      print(exc);
      // permission not granted
    }*/

    _setLocation(position.latitude, position.longitude);
  }

  _pickOnMap() async {
    var pickedLocation = await Navigator.of(context)
        .push<LatLng?>(MaterialPageRoute(builder: (ctx) {
      return const MapScreen(
        isSelecting: true,
      );
    }));

    if (pickedLocation == null) {
      return;
    }

    _setLocation(pickedLocation.latitude, pickedLocation.longitude);
  }

  _setLocation(double latitude, double longitude) async {
    print("location is $latitude,$longitude");

    var uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleKey');
    var response = await http.get(uri);
    var data = jsonDecode(response.body);
    var address = data['results'][0]['formatted_address'] as String;

    print('address is $address');

    setState(() {
      _location = Location(lat: latitude, lng: longitude, address: address);
    });

    widget.onLocationPicked(_location!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 200,
        width: double.infinity,
        child: _location == null
            ? _isLoading
                ? const Center(child: CircularProgressIndicator())
                : null
            : Image.network(
                StaticMapService.getStaticMap(_location!.lat, _location!.lng),
              ),
      ),
      const SizedBox(height: 10),
      Row(children: [
        TextButton.icon(
          icon: const Icon(Icons.gps_fixed),
          onPressed: _getLocation,
          label: const Text('Get current location'),
        ),
        const SizedBox(width: 10),
        TextButton.icon(
          icon: const Icon(Icons.map),
          onPressed: _pickOnMap,
          label: const Text('Pick location on map'),
        ),
      ]),
    ]);
  }
}

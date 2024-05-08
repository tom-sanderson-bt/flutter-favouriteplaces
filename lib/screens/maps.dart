import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const LatLng(45.521563, -122.677433),
      this.isSelecting = false});

  final LatLng location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  _onSaveMapLocation() {
    Navigator.of(context).pop(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isSelecting
            ? const Text('Select a location')
            : const Text('Place location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _onSaveMapLocation,
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting
            ? (pickedPosition) {
                setState(() {
                  _pickedLocation = pickedPosition;
                });
              }
            : null,
        initialCameraPosition:
            CameraPosition(target: widget.location, zoom: 11.0),
        markers: (widget.isSelecting && _pickedLocation == null)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('location'),
                  position: _pickedLocation ?? widget.location,
                )
              },
      ),
    );
  }
}

import "package:favourite_places/secrets.dart";

class StaticMapService {
  static getStaticMap(double lat, double lng) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&key=$googleKey';
  }
}

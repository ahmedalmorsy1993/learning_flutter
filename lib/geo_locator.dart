import 'package:geolocator/geolocator.dart';

class CustomGeolocator {
  static final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  static Future<void> _checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied. Enable them in settings.',
      );
    }
  }

  static Future<Position> determinePosition() async {
    await _checkPermission();
    return Geolocator.getCurrentPosition(locationSettings: locationSettings);
  }

  static Stream<Position> getPositionStream() async* {
    await _checkPermission();
    yield* Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}

// ignore_for_file: file_names

import 'package:geolocator/geolocator.dart';

class GeolocationApi {
  final geolocator;

  GeolocationApi({required this.geolocator});

  Future<Position> get currentLocationGetter {
    print('currentLocationGetter called');
    return _determinePosition(geolocator: geolocator);
}

Future<Position> _determinePosition({required geolocator}) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  print('_determinePositioned called.');

  serviceEnabled = await geolocator.isLocationServiceEnabled();
  print('_determinePositioned called.');

  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // return Future.error('Location services are disabled.');
    print('Location services are disabled.');
    throw const LocationServiceDisabledException();
  }

  permission = await geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      print('Permission denied.');
      throw const PermissionDeniedException('');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    // return Future.error(
    //     'Location permissions are permanently denied, we cannot request permissions.');
    print('Permission denied forever.');
    throw const PermissionDeniedException('Location permissions are permanently denied,'
        ' we cannot request permissions.');

  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  print('Permission granted.');

  return await geolocator.getCurrentPosition();
}
}
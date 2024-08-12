import 'dart:async';
import 'dart:developer';

import 'package:db_atom/src/models/responseModels/permission_error.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  // if (serviceEnabled) {
  //   return await getLocation();
  // }
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // return Future.error('Location services are disabled.');
    throw PermissionError(message: 'Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  // log('-permission----checkPermission-----${permission.name}----');
  if (permission == LocationPermission.denied) {
    log('-permission--${permission.name}----');
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      // return Future.error('Location permissions are denied');
      throw PermissionError(message: 'Location services are disabled.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    throw PermissionError(
        message:
            'Location is required to use this app.\nPlease enable Location');

    // return Future.error(
    //     'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await getLocation();
}

Future<Position>? _positionFuture;

Future<Position> getLocation() async {
  if (_positionFuture != null) {
    // If a future is already in progress, return it directly
    return _positionFuture!;
  } else {
    // If no future is in progress, start a new one
    Completer<Position> completer = Completer<Position>();
    _positionFuture = completer.future;

    // Fetch the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      // Complete the future with the fetched position
      completer.complete(position);
    } catch (e) {
      // Handle any errors and complete the future with an error
      completer.completeError(e);
    }
    // Wait for the future to complete and then return its result
    return await _positionFuture!;
  }
}

Completer<PermissionStatus>? _permissionCompleter;

Future<PermissionStatus> requestLocationPermission() {
  if (_permissionCompleter != null && !_permissionCompleter!.isCompleted) {
    return _permissionCompleter!.future;
  } else {
    _permissionCompleter = Completer<PermissionStatus>();
  }

  _requestLocationPermission();
  return _permissionCompleter!.future;
}

void _requestLocationPermission() async {
  PermissionStatus permissionStatus = await Permission.location.request();
  _permissionCompleter!.complete(permissionStatus);
}
// Future<Position> getPosition() async {
//   log('Will get Current Position now.');
//   late Position position;
//   try {
//     position = await Geolocator.getCurrentPosition(
//       forceAndroidLocationManager: false,
//       desiredAccuracy: LocationAccuracy.bestForNavigation,
//       timeLimit: const Duration(seconds: 20),
//     );
//     log('Current Position: ${position.latitude}, ${position.longitude}');
//   } on Exception catch (e) {
//     log('location fetch error: ${e.toString()}');
//   }
//   return position;
// }

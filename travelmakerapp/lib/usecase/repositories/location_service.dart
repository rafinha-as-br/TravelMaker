import 'package:geolocator/geolocator.dart';

/// location services
abstract class LocationService {

  /// to check if the gps service is enabled
  Future<bool> isServiceEnabled();

  /// to check the permission status for the app
  Future<LocationPermission> checkPermission();

  /// to request a permission
  Future<LocationPermission> requestPermission();
}

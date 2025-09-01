import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<bool> isServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
}

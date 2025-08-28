import 'package:geolocator/geolocator.dart';

abstract class LocationServiceImpl {
  Future<bool> isServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
}

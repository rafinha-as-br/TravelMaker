import 'package:geolocator/geolocator.dart';
import 'package:travelmakerapp/usecase/repositories/location_service_Impl.dart';

class LocationServiceImpl implements LocationService {
  @override
  Future<bool> isServiceEnabled() => Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  @override
  Future<LocationPermission> requestPermission() => Geolocator.requestPermission();
}

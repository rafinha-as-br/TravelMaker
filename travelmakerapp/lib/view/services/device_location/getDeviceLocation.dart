import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


Future<Placemark?> getDeviceLocation() async{
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return null;

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      return null;
    }
  }

  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

  return placemarks.isNotEmpty ? placemarks.first : null;


}
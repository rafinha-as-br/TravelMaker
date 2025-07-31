import 'package:geocoding/geocoding.dart';

String? getCity(Placemark placemark) => placemark.locality;
String? getCountry(Placemark placemark) => placemark.country;

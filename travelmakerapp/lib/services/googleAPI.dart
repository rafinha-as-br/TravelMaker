import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:travelmakerapp/services/get_api_key.dart';

// need a string that goes to image.network

String staticMapURL(double latitude, double longitude) {
  final value = 'https://maps.googleapis.com/maps/api/staticmap'
      '?size=1800x300'
      '&zoom=12'
      '&center=${latitude}, ${longitude}'
      '&key= ${getAPIKey()}';

  return value;
}


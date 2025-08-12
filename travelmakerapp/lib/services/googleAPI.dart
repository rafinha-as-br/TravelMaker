import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// need a string that goes to image.network

String staticMapURL(double latitude, double longitude) {
  final value = 'https://maps.googleapis.com/maps/api/staticmap'
      '?size=1800x300'
      '&zoom=12'
      '&center=${latitude}, ${longitude}'
      '&key=AIzaSyAgT9pV0ONamMF8ByF008OT7lf4-1oAFd0';

  return value;
}
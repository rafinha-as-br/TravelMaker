

import 'dart:ui';

import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/experiences.dart';

class TravelStop{
  //from database
  int stopID;
  int travelID;
  DateTime arrival;
  DateTime departure;
  DateTime timeSpent;
  String description;
  String cityName;
  float latitude;
  float longitude;
  Path stopPicture;

  //on app
  Experiences experiences;




}
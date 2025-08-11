

import 'dart:ffi';
import 'dart:ui';

import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/experiences.dart';

class TravelStop{
  //from database

  //from table travelStop
  int stopID;
  int travelID;
  DateTime arrival;
  DateTime departure;
  DateTime timeSpent;
  String description;
  String cityName;
  Float latitude;
  Float longitude;
  String? stopPicture;


  //from table experienceList
  List<int> experiencesID;

  TravelStop(this.stopID, this.travelID, this.arrival, this.departure,
      this.timeSpent, this.description, this.cityName, this.latitude,
      this.longitude, this.stopPicture, this.experiencesID);


}
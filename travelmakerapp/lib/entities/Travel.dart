

import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/travelStop.dart';

class Travel{

  //from database
  int travelID;
  DateTime departure;
  DateTime arrival;
  String desiredVehicle;

  //on app
  List<TravelStop> travelStopList;
  List<Person> membersList;



}
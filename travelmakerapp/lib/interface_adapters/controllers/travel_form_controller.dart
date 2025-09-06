import 'package:flutter/cupertino.dart';

class TravelClassController{

  final travelTitleController = TextEditingController();
  final travelDescriptionController = TextEditingController();

  final travelOriginCityController = TextEditingController();
  final travelOriginLatController = TextEditingController();
  final travelOriginLongController = TextEditingController();
  final bool travelOriginPassed = false;
  final DateTime? departure = null;

  final travelFinishCityController = TextEditingController();
  final travelFinishLatController = TextEditingController();
  final travelFinishLongController = TextEditingController();
  final bool travelFinishPassed = false;
  final DateTime? arrival = null;


  // to clean the memory
  void dispose(){

  }


}
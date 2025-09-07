import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entities/travelStop.dart';
import '../../view/presentation/helpers/dates/getDate.dart';

class TravelFormController{

  //----------------------- TRAVEL CONTROLLERS ---------------------------------

  final travelTitleController = TextEditingController();
  final travelDescriptionController = TextEditingController();

  final travelOriginCityController = TextEditingController();
  final travelOriginLatController = TextEditingController();
  final travelOriginLongController = TextEditingController();
  bool travelOriginPassed = false;
  DateTime? departure;
  final travelOriginDepartureController = TextEditingController();

  final travelFinishCityController = TextEditingController();
  final travelFinishLatController = TextEditingController();
  final travelFinishLongController = TextEditingController();
  bool travelFinishPassed = false;
  DateTime? arrival;
  final travelFinishArrivalController = TextEditingController();


  //------------------- TRAVEL CONTROLLERS METHODS -----------------------------

  // to clean the memory
  void dispose(){
    travelTitleController.dispose();
    travelDescriptionController.dispose();
    travelOriginCityController.dispose();
    travelOriginLatController.dispose();
    travelOriginLongController.dispose();


    travelFinishCityController.dispose();
    travelFinishLatController.dispose();
    travelFinishLongController.dispose();

  }

  void clearTravelControllers(){
    travelTitleController.clear();
    travelOriginCityController.clear();
    travelOriginLatController.clear();
    travelOriginLongController.clear();
    travelOriginPassed = false;
    departure = null;
    travelOriginDepartureController.clear();

    travelFinishCityController.clear();
    travelFinishLatController.clear();
    travelFinishLongController.clear();
    travelFinishPassed = false;
    arrival = null;
    travelFinishArrivalController.clear();

  }

  Future<void> selectTravelOriginDate(BuildContext context) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null && context.mounted){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);

      travelOriginDepartureController.text = formattedDate;
      departure = selectedDate;

    }

  }
  Future<void> selectTravelFinishDate(BuildContext context, ) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null && context.mounted){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);


      travelFinishArrivalController.text = formattedDate;
      arrival = selectedDate;

    }

  }

  void selectTravelOriginCity(Map<String, dynamic> suggestion){
    travelOriginCityController.text = suggestion['description'];
    travelOriginLatController.text = suggestion['lat'].toString();
    travelOriginLongController.text = suggestion['lng'].toString();

  }
  void selectTravelFinishCity(Map<String, dynamic> suggestion){
    travelFinishCityController.text = suggestion['description'];
    travelFinishLatController.text = suggestion['lat'].toString();
    travelFinishLongController.text = suggestion['lng'].toString();

  }

  // to set the controllers and variables to receive their values from a stop






}
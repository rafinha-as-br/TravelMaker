import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

import '../../usecase/dates/getDate.dart';

class CreateTravelProvider with ChangeNotifier{

  DateTime? startDate;

  //controllers
  final travelTitle = TextEditingController();
  final travelDescription = TextEditingController();
  final travelDestination = TextEditingController();
  final travelStartDate = TextEditingController();
  final travelFinalDate = TextEditingController();

  //travel person list
  List<Person> travelPersonsList = [];

  //vehicle chosen
  Vehicles vehicleChosen = Vehicles.notSelected;


  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }

  //update persons function
  void updatePersonsList(Person person, {int? index}) {
    if (index != null) {
      travelPersonsList[index] = person;
    } else {
      travelPersonsList.add(person);
    }
    notifyListeners();
  }


  void removePerson(index){
    travelPersonsList.removeAt(index);
    notifyListeners();
  }


  Future<void> selectDate(BuildContext context,) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null){
      travelStartDate.text = selectedDate.toString().split(' ')[0];
      notifyListeners();
    }

  }



}
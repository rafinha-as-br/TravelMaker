import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import '../../usecase/dates/getDate.dart';
import '../../usecase/sharedPreferences/sharedPreferencesInstance.dart';

class CreateTravelProvider with ChangeNotifier{
  final sharedPreferences = SharedPreferencesInstance().preferences;

  bool userAdded = false;

  DateTime? startDate;

  //controllers
  final travelTitle = TextEditingController();
  final travelDescription = TextEditingController();
  final travelDestination = TextEditingController();
  final travelStartDate = TextEditingController();
  final travelFinalDate = TextEditingController();



  //vehicle chosen
  Vehicles vehicleChosen = Vehicles.notSelected;

  bool isVehicleExpanded = true;

  //travel person list
  List<Person> travelPersonsList = [];



  Future<String> getUserName() async {
    String? name = sharedPreferences.getString('userName');
    return name ?? '';
  }

  Future<int> getUserAge() async {
    int? age = sharedPreferences.getInt('userAge');
    return age ?? 0;
  }

  Future<void> addUserToPersonList() async{
    final name = await getUserName();
    final age = await getUserAge();
    updatePersonsList(Person(name: name, age: age));
    notifyListeners();
  }


  void toggleVehicleExpanded(bool expanded) {
    isVehicleExpanded = expanded;
    notifyListeners();
  }

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
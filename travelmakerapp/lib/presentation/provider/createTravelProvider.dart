import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

import '../../usecase/dates/getDate.dart';

class CreateTravelProvider with ChangeNotifier{

  List<Person> personsList = [];

  DateTime? startDate;

  final travelStartDate = TextEditingController();
  final travelFinalDate = TextEditingController();


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
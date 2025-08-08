import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';

import '../../usecase/dates/getDate.dart';

class CreateTravelProvider with ChangeNotifier{

  List<Person> personsList = [Person(name: "Lucas", age: 19), Person(name: "Alexandre", age: 20)];

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
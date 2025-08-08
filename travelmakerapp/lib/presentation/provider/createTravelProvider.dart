import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';

import '../../usecase/dates/getDate.dart';

class CreateTravelProvider with ChangeNotifier{


  DateTime? startDate;

  final travelTitle = TextEditingController();
  final travelDescription = TextEditingController();
  final travelDestination = TextEditingController();
  final travelStartDate = TextEditingController();
  final travelFinalDate = TextEditingController();

  List<Person> travelPersonsList = [];



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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelmakerapp/entities/comment.dart';

import '../../entities/person.dart';
import '../../entities/travelStop.dart';
import '../../view/presentation/helpers/dates/getDate.dart';

class StopFormController{

  // ----------------------------- STOP FORM CONTROLLERS -----------------------
  final stopDestinationController = TextEditingController();
  final stopDescriptionController = TextEditingController();

  final stopArrivalController = TextEditingController();
  final stopDepartureController = TextEditingController();

  final stopDestinationLatitude = TextEditingController();
  final stopDestinationLongitude = TextEditingController();

  DateTime? stopArrivalDate;
  DateTime? stopDepartureDate;

  List<Comment> comments = [];


  // -------------------------STOP FORM CONTROLLERS METHODS --------------------

  void selectStopArrivalDate(BuildContext context) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null && context.mounted){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);

      stopArrivalController.text = formattedDate;
      stopArrivalDate = selectedDate;

    }
  }

  void updateComments(Comment comment){
    comments.add(comment);
  }

  void removeComment(int index){
    comments.removeAt(index);
  }

  void selectStopDepartureDate(BuildContext context) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null && context.mounted){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);

      stopDepartureController.text = formattedDate;
      stopDepartureDate = selectedDate;

    }
  }

  void selectStopCity(Map<String, dynamic> suggestion){
    stopDestinationController.text = suggestion['description'];
    stopDestinationLatitude.text = suggestion['lat'].toString();
    stopDestinationLongitude.text = suggestion['lng'].toString();
  }

  void clearStopControllers(){
    stopDestinationController.clear();
    stopDescriptionController.clear();

    stopArrivalController.clear();
    stopDepartureController.clear();

    stopDestinationLatitude.clear();
    stopDestinationLongitude.clear();

    stopArrivalDate = null;
    stopDepartureDate = null;

  }

  void dispose(){
    stopDestinationController.dispose();
    stopDescriptionController.dispose();

    stopArrivalController.dispose();
    stopDepartureController.dispose();

    stopDestinationLatitude.dispose();
    stopDestinationLongitude.dispose();
  }


  // to set the controllers and variables to receive their values from a stop
  void setStopEdit(TravelStop stop, BuildContext context){
    final locale = Localizations.localeOf(context).toString();
    clearStopControllers();
    stopDescriptionController.text = stop.description;
    stopDestinationLatitude.text = stop.destination.latitude.toString();
    stopDestinationLongitude.text = stop.destination.longitude.toString();

    stopArrivalDate = stop.arrival;
    stopArrivalController.text = DateFormat.yMd(locale).format(stop.arrival!);

    stopDepartureDate = stop.departure;
    stopDepartureController.text =  DateFormat.yMd(locale).format(stop.departure!);

  }

}
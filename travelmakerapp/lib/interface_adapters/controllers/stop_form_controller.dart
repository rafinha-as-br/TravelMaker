import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../entities/comment.dart';
import '../../entities/travel_stop.dart';
import '../../view/presentation/helpers/dates/getDate.dart';

/// Stop form controller, contains all the controllers for StopForm
class StopFormController{

  // ----------------------------- STOP FORM CONTROLLERS -----------------------

  /// destination controller
  final stopDestinationController = TextEditingController();

  /// description controller
  final stopDescriptionController = TextEditingController();

  /// arrival date controller
  final stopArrivalController = TextEditingController();

  /// departure date controller
  final stopDepartureController = TextEditingController();

  /// destination latitude controller
  final stopDestinationLatitude = TextEditingController();

  /// destination longitude controller
  final stopDestinationLongitude = TextEditingController();

  /// datetime arrival
  DateTime? stopArrivalDate;
  /// datetime departure
  DateTime? stopDepartureDate;

  /// comment list
  List<Comment> comments = [];


  // -------------------------STOP FORM CONTROLLERS METHODS --------------------

  /// select the arrival date method
  void selectStopArrivalDate(BuildContext context) async{
    final selectedDate = await showDatePicker(
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

  /// update comment method
  void updateComments(Comment comment){
    comments.add(comment);
  }

  /// remove comment method
  void removeComment(int index){
    comments.removeAt(index);
  }

  /// select departure date method
  void selectStopDepartureDate(BuildContext context) async{
    final selectedDate = await showDatePicker(
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

  /// select stop city method
  void selectStopCity(Map<String, dynamic> suggestion){
    stopDestinationController.text = suggestion['description'];
    stopDestinationLatitude.text = suggestion['lat'].toString();
    stopDestinationLongitude.text = suggestion['lng'].toString();
  }

  /// clear stop controllers method
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

  /// dispose controller method
  void dispose(){
    stopDestinationController.dispose();
    stopDescriptionController.dispose();

    stopArrivalController.dispose();
    stopDepartureController.dispose();

    stopDestinationLatitude.dispose();
    stopDestinationLongitude.dispose();
  }


  /// to set the controllers and variables to receive their values from a stop
  void setStopEdit(TravelStop stop, BuildContext context){
    final locale = Localizations.localeOf(context).toString();
    clearStopControllers();
    stopDescriptionController.text = stop.description;
    stopDestinationLatitude.text = stop.destination.latitude.toString();
    stopDestinationLongitude.text = stop.destination.longitude.toString();

    stopArrivalDate = stop.arrival;
    stopArrivalController.text = DateFormat.yMd(locale).format(stop.arrival!);

    stopDepartureDate = stop.departure;
    stopDepartureController.text = DateFormat.yMd(locale).format(
        stop.departure!
    );

  }

}
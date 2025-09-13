import 'package:travelmakerapp/entities/comment.dart';
import 'package:travelmakerapp/entities/destination.dart';
import 'package:travelmakerapp/entities/validator.dart';

import 'Travel.dart';

class TravelStop{

  int? stopID;
  int? travelID;
  DateTime? arrival;
  DateTime? departure;
  Destination destination;
  String? stopPicture;
  String description;
  List<Comment> comments = [];

  TravelStop({
    required this.arrival,
    required this.departure,
    required this.destination,
    required this.description,}
  );


  //dates validator *in a stop, you arrive and then you departure from it
  Validator stopDatesValidator(DateTime? arrival, DateTime? departure){
    DateTime today = DateTime.now();
    if(arrival == null || departure == null){
      return Validator(false, "datesNotSelected");
    }
    if(arrival.isBefore(today)){
      return Validator(false, 'departureDateBeforeToday');
    }
    if(arrival.isAfter(departure)){
      return Validator(false, 'arrivalDateBeforeDeparture');
    }

    return Validator(true, null);
  }

  Validator descriptionValidator(String value){
    if(value.isEmpty){
      return Validator(false, "descriptionEmpty");
    }
    return Validator(true, null);
  }

  Validator validateStop(TravelStop stop){
    final destinationValidate = stop.destination.validateDestination(stop.destination);
    if(!destinationValidate.success){
      return destinationValidate;
    }

    final stopDatesValidate = stopDatesValidator(stop.arrival, stop.departure);
    if(!stopDatesValidate.success){
      return stopDatesValidate;
    }

    return Validator(true, null);
  }

  Validator completeStop() {
    if(stopPicture == null){
      return Validator(false, 'needPicture');
    }
    DateTime date = DateTime.now();
    if(date.isBefore(arrival!)){
      return Validator(false, 'DateBeforeArrival');
    }
    return Validator(true, null);

  }


  bool checkStopDone(){
    final checkStop = completeStop();
    if(!checkStop.success){
      return false;
    }
    return true;
  }


  Map<String, dynamic> toMap(int travelID){
    return {
      'travel_id': travelID,
      'stop_destination': destination.city,
      'destination_lat': destination.latitude,
      'destination_long': destination.longitude,
      'stop_descr': description,
      'departure': departure?.toIso8601String(),
      'arrival': arrival?.toIso8601String(),
      'stop_picture_path': stopPicture,
    };
  }

  factory TravelStop.fromMap(Map<String, dynamic> map) {
    return TravelStop(
      map['arrival'] != null ? DateTime.parse(map['arrival']) : null,
      map['departure'] != null ? DateTime.parse(map['departure']) : null,
      Destination(
        map['stop_destination'] ?? '',
        map['destination_lat'] ?? 0.0,
        map['destination_long'] ?? 0.0,

      ),
      map['stop_descr'] ?? '',
    )
      ..stopID = map['stop_id']
      ..travelID = map['travel_id']
      ..stopPicture = map['stop_picture_path'];
  }




}
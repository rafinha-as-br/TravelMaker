import 'comment.dart';
import 'destination.dart';
import 'travel_stop_status.dart';
import 'validator.dart';

/// TravelStop entity, that stores everything related to a travel stop
class TravelStop{

  /// from database
  int? stopID;

  /// travelID that is passed to during the insert on databse
  int? travelID;

  /// date of arrival in the stop
  DateTime? arrival;

  /// date of departure from the stop
  DateTime? departure;

  /// destination of the stop
  Destination destination;

  /// stop picture
  String? stopPicture;

  /// description of the stop
  String description;

  /// comments of the stop
  List<Comment> comments = [];

  /// default constructor
  TravelStop({
    required this.arrival,
    required this.departure,
    required this.destination,
    required this.description,}
  );


  ///dates validator *in a stop, you arrive and then you departure from it
  Validator stopDatesValidator(DateTime? arrival, DateTime? departure){
    final today = DateTime.now();
    if(arrival == null || departure == null){
      return Validator(false, 'datesNotSelected');
    }
    if(arrival.isBefore(today)){
      return Validator(false, 'departureDateBeforeToday');
    }
    if(arrival.isAfter(departure)){
      return Validator(false, 'arrivalDateBeforeDeparture');
    }

    return Validator(true, null);
  }

  /// description validator
  Validator descriptionValidator(String value){
    if(value.isEmpty){
      return Validator(false, 'descriptionEmpty');
    }
    return Validator(true, null);
  }

  /// stop validator
  Validator validateStop(TravelStop stop){
    final destinationValidate = stop.destination.validateDestination(
        stop.destination
    );
    if(!destinationValidate.success){
      return destinationValidate;
    }

    final stopDatesValidate = stopDatesValidator(stop.arrival, stop.departure);
    if(!stopDatesValidate.success){
      return stopDatesValidate;
    }

    return Validator(true, null);
  }

  /// complete stop method
  Validator completeStop() {
    final date = DateTime.now();
    if(date.isBefore(arrival!)){
      return Validator(false, 'DateBeforeArrival');
    }
    if(stopPicture == null){
      return Validator(false, 'needPicture');
    }

    return Validator(true, null);

  }

  /// check the stop status and return a TravelStopStatus
  TravelStopStatus checkStopStatus(){
    final checkStop = completeStop();
    if(!checkStop.success){
      if(checkStop.message== 'DateBeforeArrival'){
        return TravelStopStatus.notDone;
      }
      if(checkStop.message == 'needPicture'){
        return TravelStopStatus.inProgress;
      }
    }
    return TravelStopStatus.done;
  }

  /// travel stop to map method
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

  /// travel stop from map method
  factory TravelStop.fromMap(Map<String, dynamic> map) {
    return TravelStop(
        arrival: map['arrival'] != null ?
          DateTime.parse(map['arrival']) : null,
        departure: map['departure'] != null ?
          DateTime.parse(map['departure']) : null,
        destination: Destination(
          map['stop_destination'] ?? '',
          map['destination_lat'] ?? 0.0,
          map['destination_long'] ?? 0.0,
        ),
        description: map['stop_descr'] ?? '',
    )
    ..stopID = map['stop_id']
    ..travelID = map['travel_id']
    ..stopPicture = map['stop_picture_path'];
  }





}
import 'package:travelmakerapp/entities/destination.dart';
import 'package:travelmakerapp/entities/validator.dart';

class TravelStop{

  int? stopID;
  int? travelID;
  DateTime? arrival;
  DateTime? departure;
  Destination destination;
  String? stopPicture;
  String description;

  TravelStop(this.arrival, this.departure, this.destination, this.description
  );

  //destination validator
  Validator destinationValidator(Destination destination){
    if(destination.city.isEmpty){
      return Validator(false, "cityEmpty");
    }
    if(destination.longitude == 0 || destination.latitude == 0){
      return Validator(false, 'invalidCoordinates');
    }
    return Validator(true, null);
  }

  //dates validator
  Validator stopDatesValidator(DateTime? arrival, DateTime? departure){
    DateTime today = DateTime.now();
    if(arrival == null || departure == null){
      return Validator(false, "datesNotSelected");
    }
    if(arrival.isBefore(today)){
      return Validator(false, 'departureDateBeforeToday');
    }
    if(arrival.isBefore(departure)){
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
    final destinationValidate = destinationValidator(stop.destination);
    if(!destinationValidate.success){
      return destinationValidate;
    }

    final stopDatesValidate = stopDatesValidator(stop.departure, stop.arrival);
    if(!stopDatesValidate.success){
      return stopDatesValidate;
    }

    return Validator(true, null);
  }

}
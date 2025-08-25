import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/validator.dart';

class TravelStop{

  int? stopID;
  int? travelID;
  DateTime arrival;
  DateTime departure;
  String cityName;
  double latitude;
  double longitude;
  String? stopPicture;
  String description;

  TravelStop(this.arrival, this.departure, this.cityName,
      this.latitude, this.longitude, this.description
  );

  //validators
  Validator cityValidator(String value){
    if(value.isEmpty){
      return Validator(false, "cityEmpty");
    }
    return Validator(true, null);
  }

  Validator stopDatesValidator(DateTime arrival, DateTime departure){
    DateTime today = DateTime.now();
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
    final cityValidate = cityValidator(stop.cityName);
    if(!cityValidate.success){
      return cityValidate;
    }
    final stopDatesValidate = stopDatesValidator(stop.departure, stop.arrival);
    if(!stopDatesValidate.success){
      return stopDatesValidate;
    }

    return Validator(true, null);
  }

}
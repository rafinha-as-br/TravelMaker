

import 'dart:ffi';
import 'dart:ui';

import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/experiences.dart';
import 'package:travelmakerapp/entities/response.dart';

class TravelStop{
  //from database

  //from table travelStop
  int? stopID;
  int? travelID;

  DateTime arrival;
  DateTime departure;
  String cityName;
  List<ExperiencesList> experiencesList;
  double latitude;
  double longitude;
  String? stopPicture;


  TravelStop(this.arrival, this.departure, this.cityName,
      this.experiencesList, this.latitude, this.longitude
  );

  //validators
  Validator cityValidator(String value){
    if(value.isEmpty){
      return Validator(false, "cityEmpty");
    }
    return Validator(true, null);
  }

  Validator stopDatesValidator(DateTime departure, DateTime arrival){
    DateTime today = DateTime.now();
    if(departure.isBefore(today)){
      return Validator(false, 'departureDateBeforeToday');
    }
    if(arrival.isBefore(departure)){
      return Validator(false, 'arrivalDateBeforeDeparture');
    }
    return Validator(true, null);
  }

  Validator stopExperiencesValidator(List<ExperiencesList> experiencesList){
    if(experiencesList.isEmpty){
      return Validator(false, 'experiencesListEmpty');
    }
    return Validator(true, null);
  }

  Validator stopValidator(TravelStop stop){
    final cityValidate = cityValidator(stop.cityName);
    if(!cityValidate.success){
      return cityValidate;
    }
    final stopDatesValidate = stopDatesValidator(stop.departure, stop.arrival);
    if(!stopDatesValidate.success){
      return stopDatesValidate;
    }

    final stopExperiencesValidate = stopExperiencesValidator(stop.experiencesList);
    if(!stopExperiencesValidate.success){
      return stopExperiencesValidate;
    }

    return Validator(true, null);
  }

}
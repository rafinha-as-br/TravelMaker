
import 'package:travelmakerapp/entities/validator.dart';

import 'destination.dart';

class Finish{

  String city;
  num latitude;
  num longitude;
  DateTime arrivalDate;
  bool passed;

  Finish({
    required this.city, required this.latitude,
    required this.longitude, required this.arrivalDate,
    required this.passed
  });

  //city validator
  Validator cityValidator(String value){
    if(value.isEmpty){
      return Validator(false, 'cityEmpty');
    }
    return Validator(true, null);
  }

  //coordinates validator
  Validator coordinatesValidator(num value1, num value2){
    if(value1 == 0 || value2 == 0){
      return Validator(false, 'invalidCoordinates');
    }
    return Validator(true, null);
  }



  Validator validateFinish(Finish finish){
    Validator validateCity = cityValidator(finish.city);
    if(!validateCity.success){
      return validateCity;
    }

    Validator validateCords = coordinatesValidator(finish.latitude, finish.longitude);
    if(!validateCords.success){
      return validateCords;
    }

    return Validator(true, null);
  }

}
import 'package:travelmakerapp/entities/destination.dart';
import 'package:travelmakerapp/entities/validator.dart';

class Origin{

  String city;
  num latitude;
  num longitude;
  DateTime departureDate;
  bool passed;


  Origin(
      this.city, this.latitude,
      this.longitude, this.departureDate,
      this.passed
  );

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


  Validator validateOrigin(Origin origin){
    Validator validateCity = cityValidator(origin.city);
    if(!validateCity.success){
      return validateCity;
    }

    Validator validateCords = coordinatesValidator(origin.latitude, origin.longitude);
    if(!validateCords.success){
      return validateCords;
    }
    return Validator(true, null);

  }


}
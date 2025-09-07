import 'package:travelmakerapp/entities/validator.dart';

class Destination {
  String city;
  num latitude;
  num longitude;
  bool passed;

  Destination(
      this.city,
      this.latitude,
      this.longitude,
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

  Validator validateDestination(Destination destination){
    Validator validateCity = cityValidator(destination.city);
    if(!validateCity.success){
      return validateCity;
    }

    Validator validateCords = coordinatesValidator(destination.latitude, destination.longitude);
    if(!validateCords.success){
      return validateCords;
    }
    return Validator(true, null);

  }
}


import 'validator.dart';

/// origin entity, that stores the start point of the travel
class Origin{

  /// city of starting of
  String city;

  /// coords - lat
  num latitude;

  /// coords - long
  num longitude;

  /// start date of the travel
  DateTime departureDate;

  /// if passed or not from the origin
  bool passed;

  ///
  Origin({
    required this.city, required this.latitude,
    required this.longitude, required this.departureDate,
    required this.passed
  });

  ///city validator
  Validator cityValidator(String value){
    if(value.isEmpty){
      return Validator(false, 'cityEmpty');
    }
    return Validator(true, null);
  }

  ///coordinates validator
  Validator coordinatesValidator(num value1, num value2){
    if(value1 == 0 || value2 == 0){
      return Validator(false, 'invalidCoordinates');
    }
    return Validator(true, null);
  }

  /// origin validator
  Validator validateOrigin(Origin origin){
    final validateCity = cityValidator(origin.city);
    if(!validateCity.success){
      return validateCity;
    }

    final validateCords = coordinatesValidator(
        origin.latitude, origin.longitude
    );
    if(!validateCords.success){
      return validateCords;
    }
    return Validator(true, null);

  }


}
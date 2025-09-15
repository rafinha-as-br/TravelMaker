import 'validator.dart';

/// finish entity, that stores the final destination of a travel
class Finish{

  /// final city of the travel
  String city;

  /// coords - lat
  num latitude;

  /// coods - long
  num longitude;

  /// arrival date
  DateTime arrivalDate;

  /// if it passed into the final city
  bool passed;

  ///
  Finish({
    required this.city, required this.latitude,
    required this.longitude, required this.arrivalDate,
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

  /// finish entity validator
  Validator validateFinish(Finish finish){
    final validateCity = cityValidator(finish.city);
    if(!validateCity.success){
      return validateCity;
    }

    final validateCords = coordinatesValidator(
        finish.latitude, finish.longitude
    );
    if(!validateCords.success){
      return validateCords;
    }

    return Validator(true, null);
  }

}
import 'validator.dart';

/// a destination entity that contains some data related to it
class Destination {

  /// city of the destination
  String city;

  /// coords lat
  num latitude;

  /// coords long
  num longitude;

  ///
  Destination(
      this.city,
      this.latitude,
      this.longitude,
  );

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

  /// destination validator
  Validator validateDestination(Destination destination){
    final validateCity = cityValidator(destination.city);
    if(!validateCity.success){
      return validateCity;
    }

    final validateCords = coordinatesValidator(
        destination.latitude, destination.longitude
    );
    if(!validateCords.success){
      return validateCords;
    }
    return Validator(true, null);

  }
}


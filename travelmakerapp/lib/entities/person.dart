import 'validator.dart';
import 'vehicles.dart';

/// person entity
class Person{

  /// personID that comes from database
  int? personId;

  /// travelID that is passed on the database insert
  int? travelID;

  /// name of the person
  String name;

  /// age of the person
  int age;

  /// profile picture of the person
  String? profilePicture;

  /// preferred vehicle of the person
  Vehicles preferredVehicle;

  ///
  Person({
    required this.name,
    required this.age,
    required this.preferredVehicle,
    this.profilePicture
  });

  /// name validator
  Validator personNameValidator(String value){
    if(value.isEmpty){
      return Validator(false, 'personNameEmpty');
    }
    if(value.length < 3){
      return Validator(false, 'personNameShort');
    }
    return Validator(true, null);
  }

  /// age validator
  Validator personAgeValidator(int value){
    if(value <= 0){
      return Validator(false, 'notNumber');
    }
    return Validator(true, null);
  }

  /// vehicle validator
  Validator personPreferredVehicleValidator(Vehicles vehicle){
    if(vehicle == Vehicles.notSelected){
      return Validator(false, 'vehicleNotSelected');
    }
    return Validator(true, null);
  }

  /// person validator
  Validator validatePerson(Person person){
    final nameValidator = personNameValidator(person.name);
    if(!nameValidator.success){
      return nameValidator;
    }
    final ageValidator = personAgeValidator(person.age);
    if(!ageValidator.success){
      return ageValidator;
    }
    final vehicleValidator = personPreferredVehicleValidator(
        person.preferredVehicle
    );
    if(!vehicleValidator.success){
      return vehicleValidator;
    }
    return Validator(true, null);
  }

  /// person to map method
  Map<String, dynamic> toMap(int travelID) {
    return {
      'personID': personId,
      'travel_id': travelID,
      'person_name': name,
      'person_age': age,
      'preferred_vehicle': getVehicleId(preferredVehicle),
      'profile_picture_path': profilePicture,
    };
  }

  /// factory builder of person from a map
  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['person_name'],
      age: map['person_age'],
      preferredVehicle: getVehicleById(map['preferred_vehicle']),
      profilePicture: map['profile_picture_path'],
    )..personId = map['personID']..travelID = map['travel_id'];
  }


}
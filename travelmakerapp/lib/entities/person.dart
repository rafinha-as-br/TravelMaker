
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

class Person{

  int? personId;
  int? travelID;
  String name;
  int age;
  String? profilePicture;
  Vehicles preferredVehicle;


  Person({required this.name, required this.age, required this.preferredVehicle, this.profilePicture});

  Validator personNameValidator(String value){
    if(value.isEmpty){
      return Validator(false, 'personNameEmpty');
    }
    if(value.length < 3){
      return Validator(false, 'personNameShort');
    }
    return Validator(true, null);
  }

  Validator personAgeValidator(int value){
    if(value <= 0){
      return Validator(false, 'notNumber');
    }
    return Validator(true, null);
  }

  Validator personPreferredVehicleValidator(Vehicles vehicle){
    if(vehicle == Vehicles.notSelected){
      return Validator(false, 'vehicleNotSelected');
    }
    return Validator(true, null);
  }

  Validator validatePerson(Person person){
    final nameValidator = personNameValidator(person.name);
    if(!nameValidator.success){
      return nameValidator;
    }
    final ageValidator = personAgeValidator(person.age);
    if(!ageValidator.success){
      return ageValidator;
    }
    final vehicleValidator = personPreferredVehicleValidator(person.preferredVehicle);
    if(!vehicleValidator.success){
      return vehicleValidator;
    }
    return Validator(true, null);
  }

  Map<String, dynamic> toMap() {
    return {
      'personID': personId,
      'travel_id': travelID,
      'person_name': name,
      'person_age': age,
      'preferred_vehicle': getVehicleId(preferredVehicle),
      'profile_picture_path': profilePicture,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['person_name'],
      age: map['person_age'],
      preferredVehicle: getVehicleById(map['preferred_vehicle'].toString()) as Vehicles,
      profilePicture: map['profile_picture_path'],
    )..personId = map['personID']..travelID = map['travel_id'];
  }


}
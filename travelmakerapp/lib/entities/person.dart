

import 'dart:ui';

import 'package:travelmakerapp/entities/validator.dart';

class Person{

  //from database
  int? personId;
  String name;
  int age;
  String? profilePicture;

  Person({this.personId, required this.name, required this.age, this.profilePicture});

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

  Validator validatePerson(Person person){
    final nameValidator = personNameValidator(person.name);
    if(!nameValidator.success){
      return nameValidator;
    }
    final ageValidator = personAgeValidator(person.age);
    if(!ageValidator.success){
      return ageValidator;
    }
    return Validator(true, null);
  }


}
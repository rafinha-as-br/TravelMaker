import 'dart:io';
import 'dart:ui';

import 'package:travelmakerapp/entities/validator.dart';

import 'Travel.dart';

class User{
  String name;
  int age;
  int? userID;
  String? profilePicturePath;


  User(
    this.name, this.age,
  );

  //validates the name
  Validator nameValidator(String value){
    if(value.isEmpty){
      return Validator(false, 'personNameEmpty');
    }
    if(value.length<3){
      return Validator(false, 'personNameShort');
    }
    return Validator(true, null);
  }

  //validate the age
  Validator ageValidator(int value){
    if(value <= 0){
      return Validator(false, 'notNumber');
    }
    return Validator(true, null);
  }

  // validates all the User validators and returns the status
  Validator userValidate(User user){
    Validator nameValidate = nameValidator(user.name);
    if(!nameValidate.success){
      return nameValidate;
    }
    Validator ageValidate = ageValidator(user.age);
    if(!ageValidate.success){
      return ageValidate;
    }

    return Validator(true, null);

  }

  Map<String, dynamic> toMap() {
    return {
      'user_name': name,
      'user_age': age,
      'user_profile_picture_path': profilePicturePath ?? '',
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['user_name'] as String,
      map['user_age'] as int,

    )
      ..userID = map['userID'] as int?
      ..profilePicturePath = map['user_profile_picture_path'] as String?;
  }




}
import 'validator.dart';

/// user entity, stores everything related to it
class User{

  /// user name
  String name;

  /// user age
  int age;

  /// userID, used for database
  int? userID;

  /// user profile picture
  String? profilePicturePath;

  /// user default constructor
  User(
    this.name, this.age,
  );

  ///validates the name
  Validator nameValidator(String value){
    if(value.isEmpty){
      return Validator(false, 'personNameEmpty');
    }
    if(value.length<3){
      return Validator(false, 'personNameShort');
    }
    return Validator(true, null);
  }

  ///validate the age
  Validator ageValidator(int value){
    if(value <= 0){
      return Validator(false, 'notNumber');
    }
    return Validator(true, null);
  }

  /// validates all the User validators and returns the status
  Validator userValidate(User user){
    final nameValidate = nameValidator(user.name);
    if(!nameValidate.success){
      return nameValidate;
    }
    final ageValidate = ageValidator(user.age);
    if(!ageValidate.success){
      return ageValidate;
    }

    return Validator(true, null);

  }

  /// user to map method
  Map<String, dynamic> toMap() {
    return {
      'user_name': name,
      'user_age': age,
      'user_profile_picture_path': profilePicturePath ?? '',
    };
  }

  /// factory user from map method
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['user_name'] as String,
      map['user_age'] as int,

    )
      ..userID = map['userID'] as int?
      ..profilePicturePath = map['user_profile_picture_path'] as String?;
  }




}
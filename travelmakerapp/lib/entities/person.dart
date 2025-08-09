

import 'dart:ui';

class Person{

  //from database
  int? personId;
  String name;
  int age;
  String? profilePicture;

  Person({this.personId, required this.name, required this.age, this.profilePicture});
}
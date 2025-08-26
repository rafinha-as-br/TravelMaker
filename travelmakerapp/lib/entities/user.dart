import 'dart:io';
import 'dart:ui';

import 'Travel.dart';

class User{
  String? name;
  int? age;
  bool ative;
  bool darkTheme;
  String? language;
  Locale locale;
  File? profilePicture;
  String? profilePicturePath;
  List<Travel>? travelList;


  User(this.name, this.age, this.ative, this.darkTheme, this.language,
      this.locale, this.profilePicture);


}
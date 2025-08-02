import 'dart:io';
import 'dart:ui';

class User{
  String? name;
  int? age;
  bool ative;
  bool darkTheme;
  String? language;
  Locale locale;
  File? profilePicture;
  String? profilePicturePath;

  User(this.name, this.age, this.ative, this.darkTheme, this.language,
      this.locale, this.profilePicture);


}
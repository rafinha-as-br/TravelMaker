
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';

Future<void> setUsername(User user,String name, SharedPreferences sharedPreferences) async{
  await sharedPreferences.setString('userName', name);
  user.name = name;
}

Future<void> setUserAge(User user, int age, SharedPreferences sharedPreferences) async{
  await sharedPreferences.setInt('userAge', age);
  user.age = age;
}

Future<void> setUserAtive(User user,bool ative, SharedPreferences sharedPreferences) async{
  await sharedPreferences.setBool('userAtive', ative);
  user.ative = ative;
}

// this is used only in toggleLanguage function,
Future<void> setUserLanguage(User user, String languageCode, SharedPreferences sharedPreferences) async{
  await sharedPreferences.setString('languageCode', languageCode);
  user.locale = Locale(languageCode);
}

//this is used on toogleTheme button
Future<void> setUserTheme(User user, bool isDark, SharedPreferences sharedPreferences) async{
  user.darkTheme = isDark;
  await sharedPreferences.setBool('darkTheme', isDark);
}


// this function is used only on userForm, need to rename for better understanding
Future<void> setUserData(User user, String name, int age, bool ative, SharedPreferences sharedPreferences) async{
  await setUsername(user, name, sharedPreferences);
  await setUserAge(user, age, sharedPreferences);
  await setUserAtive(user, ative, sharedPreferences);
  // need a notify listeners here after this function

}

import 'dart:ui';
import 'package:travelmakerapp/usecase/pickImageFromGallery.dart';
import 'package:travelmakerapp/usecase/sharedPreferences/sharedPreferencesInstance.dart';

import '../../entities/user.dart';

Future<void> setUsername(User user,String name) async{
  final sharedPreferences = SharedPreferencesInstance().preferences;
  await sharedPreferences.setString('userName', name);
  user.name = name;
}

Future<void> setUserAge(User user, int age) async{
  final sharedPreferences = SharedPreferencesInstance().preferences;
  await sharedPreferences.setInt('userAge', age);
  user.age = age;
}

Future<void> setUserAtive(User user, bool ative) async{
  final sharedPreferences = SharedPreferencesInstance().preferences;
  await sharedPreferences.setBool('userAtive', ative);
  user.ative = ative;
}

// this is used only in toggleLanguage function
Future<void> setUserLanguage(User user, String languageCode) async{
  final sharedPreferences = SharedPreferencesInstance().preferences;
  await sharedPreferences.setString('languageCode', languageCode);
  user.locale = Locale(languageCode);
  user.language = languageCode;
  // need a notify listeners here after this function

}

//this is used on toogleTheme button
Future<void> setUserTheme(User user, bool isDark) async{
  final sharedPreferences = SharedPreferencesInstance().preferences;
  await sharedPreferences.setBool('darkTheme', isDark);
  user.darkTheme = isDark;
  // need a notify listeners here after this function

}

// this is used in userConfigScreen
Future<void> setUserProfilePicPath(User user) async{
  final sharedPreferences = SharedPreferencesInstance().preferences;
  user.profilePicture = await pickImageFromGallery();
  await sharedPreferences.setString('profilePicPath', user.profilePicture!.path);
  // need a notify listeners here after this function
}


// this function is used only on userForm
Future<void> setUserData(User user, String name, int age, bool ative) async{
  await setUsername(user, name);
  await setUserAge(user, age);
  await setUserAtive(user, ative);
  // need a notify listeners here after this function

}

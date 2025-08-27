import 'dart:ui';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/interface_adapters/repositories/sharedPreferencesInstance.dart';

import 'package:flutter/material.dart';

import '../../usecase/repositories/userRepository.dart';
import '../../view/presentation/helpers/pickImageFromGallery.dart';

// this is the userRepository
class SharedPreferencesUserRepository implements UserRepository {
  final SharedPreferencesInstance _prefs = SharedPreferencesInstance();

  SharedPreferencesUserRepository();

  Future<void> _initPrefs() async {
    await _prefs.init();
  }

  @override
  Future<User?> getCurrentUser() async {
    await _initPrefs();

    User user = User(
      '', 0, false, false,
      'pt', const Locale('pt'),
      null,
    );

    // getting data from sharedPreferences
    user.name = _prefs.preferences.getString('userName') ?? '';
    user.age = _prefs.preferences.getInt('userAge') ?? 0;
    user.active = _prefs.preferences.getBool('userActive') ?? false;
    user.darkTheme = _prefs.preferences.getBool('darkTheme') ?? false;
    user.language = _prefs.preferences.getString('languageCode') ?? 'pt';
    user.locale = Locale(user.language!);
    user.profilePicturePath = _prefs.preferences.getString('profilePicPath');

    return user;
  }

  @override
  Future<void> setCurrentUser(User user) async {
    await _initPrefs();

    await _prefs.preferences.setString('userName', user.name);
    await _prefs.preferences.setInt('userAge', user.age);
    await _prefs.preferences.setBool('userActive', user.active);
    await _prefs.preferences.setBool('darkTheme', user.darkTheme);

    if (user.language != null) {
      await _prefs.preferences.setString('languageCode', user.language!);
    }

    if (user.profilePicture != null) {
      await _prefs.preferences.setString('profilePicPath', user.profilePicture!.path);
    }
  }

  @override
  Future<void> clearUser() async {
    await _initPrefs();

    await _prefs.preferences.remove('userName');
    await _prefs.preferences.remove('userAge');
    await _prefs.preferences.remove('userActive');
    await _prefs.preferences.remove('darkTheme');
    await _prefs.preferences.remove('languageCode');
    await _prefs.preferences.remove('profilePicPath');
  }

  Future<void> setUsername(User user, String name) async {
    user.name = name;
    await _prefs.preferences.setString('userName', name);
  }

  Future<void> setUserAge(User user, int age) async {
    user.age = age;
    await _prefs.preferences.setInt('userAge', age);
  }

  Future<void> setUserActive(User user, bool active) async {
    user.active = active;
    await _prefs.preferences.setBool('userActive', active);
  }

  Future<void> setUserLanguage(User user, String languageCode) async {
    user.language = languageCode;
    user.locale = Locale(languageCode);
    await _prefs.preferences.setString('languageCode', languageCode);
  }

  @override
  Future<int> toggleLanguage(User user, int languageN) async {
    int nextLanguageN = (languageN + 1) % 3; // 0 -> 1 -> 2 -> 0

    switch (nextLanguageN) {
      case 0:
        await setUserLanguage(user, 'pt');
        break;
      case 1:
        await setUserLanguage(user, 'en');
        break;
      case 2:
        await setUserLanguage(user, 'es');
        break;
    }

    return nextLanguageN;
  }


  Future<void> setUserTheme(User user, bool isDark) async {
    user.darkTheme = isDark;
    await _prefs.preferences.setBool('darkTheme', isDark);
  }

  Future<void> setUserProfilePicture(User user) async {
    user.profilePicture = await pickImageFromGallery();
    if (user.profilePicture != null) {
      await _prefs.preferences.setString('profilePicPath', user.profilePicture!.path);
    }
  }

  Future<void> setUserData(User user, String name, int age, bool active) async {
    await setUsername(user, name);
    await setUserAge(user, age);
    await setUserActive(user, active);
  }



}

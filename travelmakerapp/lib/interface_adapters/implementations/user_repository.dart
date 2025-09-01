import 'dart:io';
import 'package:travelmakerapp/entities/user.dart';

import 'package:travelmakerapp/interface_adapters/implementations/sharedPreferencesInstance.dart';

import '../../entities/validator.dart';
import '../../usecase/repositories/userRepository.dart';
import '../../view/presentation/helpers/pickImageFromGallery.dart';

// this is the userRepository implementation, works as SharedPreferences implementation too
class UserRepositoryImpl implements UserRepository {
  final SharedPreferencesInstance _prefs = SharedPreferencesInstance();

  Future<void> _initPrefs() async {
    await _prefs.init();
  }

  @override
  Future<Validator> createUser(User user) {



  }

  @override
  Future<User> getCurrentUser() async {
    await _initPrefs();

    User user = User('', 0, null);

    // getting data from sharedPreferences
    user.name = _prefs.preferences.getString('userName') ?? '';
    user.age = _prefs.preferences.getInt('userAge') ?? 0;
    user.profilePicturePath = _prefs.preferences.getString('profilePicPath');

    return user;
  }

  @override
  Future<void> setCurrentUser(User user) async {
    await _initPrefs();

    await _prefs.preferences.setString('userName', user.name);
    await _prefs.preferences.setInt('userAge', user.age);

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



  // this function needs to go to presentation/helpers!
  Future<void> setUserProfilePicture(User user) async {
    File? profilePicture = await pickImageFromGallery();
    if (profilePicture != null) {
      await _prefs.preferences.setString('profilePicPath', profilePicture.path);
    }
  }



}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/userRepository.dart';

import '../../view/presentation/helpers/getFlag.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository;

  UserProvider(this._userRepository) {
    init();
  }
  User? user;
  int languageN = 0;
  CountryFlag countryFlag = getFlag('pt-BR');
  bool isDarkTheme = false;

  bool get isUserActive => user?.active ?? false;
  bool get isLoading => user == null;


  final nameController = TextEditingController();
  final ageController = TextEditingController();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    user = await _userRepository.getCurrentUser();

    user!.locale ??= const Locale('pt');
    user!.language ??= 'pt';
    isDarkTheme = user!.darkTheme;

    languageN = ['pt', 'en', 'es'].indexOf(user!.language!);
    countryFlag = getFlag(
      languageN == 0
          ? 'pt-BR'
          : languageN == 1
          ? 'en-US'
          : 'es',
    );

    notifyListeners();
  }


  Future<void> createUser() async {
    if (user == null) return;

    await _userRepository.setCurrentUser(user!);
    user!.name = nameController.text;
    user!.age = int.parse(ageController.text);
    user!.active = true;

    clearControllers();

    notifyListeners();
  }

  void clearControllers(){
    nameController.clear();
    ageController.clear();
    notifyListeners();
  }

  Future<void> removeUser() async {
    if (user == null) return;

    await _userRepository.clearUser();
    user = await _userRepository.getCurrentUser();
    notifyListeners();
  }

  Future<void> changeLanguage() async {
    if (user == null) return;

    languageN = await _userRepository.toggleLanguage(user!, languageN);

    countryFlag = getFlag(
      languageN == 0
          ? 'pt-BR'
          : languageN == 1
          ? 'en-US'
          : 'es',
    );

    user!.locale = Locale(user!.language!);

    notifyListeners();
  }

  Future<void> changeTheme(bool isDark) async {
    if (user == null) return;

    await _userRepository.setUserTheme(user!, isDark);
    isDarkTheme = isDark;
    notifyListeners();
  }

  Future<void> changeProfilePicture() async {
    if (user == null) return;

    await _userRepository.setUserProfilePicture(user!);
    notifyListeners();
  }

  Validator validateUser() {
    final user = User(
      nameController.text,
      int.tryParse(ageController.text) ?? 0,
      false,
      false,
      null,
      null,
      null,
    );

    return user.userValidate(user);
  }
}

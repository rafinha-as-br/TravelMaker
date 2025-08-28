import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/create_user.dart';
import '../../view/presentation/helpers/getFlag.dart';
import '../repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository;

  UserProvider(this._userRepository) {
    init();
  }

  User user = User('', 0, false, false, '', null, null);

  int languageN = 0;
  CountryFlag countryFlag = getFlag('pt-BR');
  bool isDarkTheme = false;


  final nameController = TextEditingController();
  final ageController = TextEditingController();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    user = await _userRepository.getCurrentUser();

    user.locale ??= const Locale('pt');
    user.language ??= 'pt';
    isDarkTheme = user.darkTheme;

    languageN = ['pt', 'en', 'es'].indexOf(user.language!);
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

    user.name = nameController.text;
    user.age = int.parse(ageController.text);
    user.active = true;
    await _userRepository.setCurrentUser(user);

    clearControllers();

    notifyListeners();
  }

  void clearControllers(){
    nameController.clear();
    ageController.clear();
    notifyListeners();
  }

  Future<void> removeUser() async {

    await _userRepository.clearUser();
    user = User('', 0, false, false, '', null, null);
    notifyListeners();
  }

  Future<void> changeLanguage() async {

    languageN = await _userRepository.toggleLanguage(user, languageN);

    countryFlag = getFlag(
      languageN == 0
          ? 'pt-BR'
          : languageN == 1
          ? 'en-US'
          : 'es',
    );

    user.locale = Locale(user.language!);

    notifyListeners();
  }

  Future<void> changeTheme(bool isDark) async {

    await _userRepository.setUserTheme(user!, isDark);
    isDarkTheme = isDark;
    notifyListeners();
  }

  Future<void> changeProfilePicture() async {

    await _userRepository.setUserProfilePicture(user);
    notifyListeners();
  }

  //gets the data from controllers and calls create_user from useCase
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

    return create_user(user);
  }
}

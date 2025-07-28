import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/entities/user.dart';

class UserProvider extends ChangeNotifier{

  var _darkTheme = false;
  get darkTheme => _darkTheme;

  set darkTheme(value) {
    _darkTheme = value;
  }

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  //create an empty user and goes to be updated on setUserName and SetUserAge
  User user = User(null, null, false);

  late SharedPreferences _sharedPreferences;

  //starting up the sharedPreferences
  Future<void> init() async {



    _sharedPreferences = await SharedPreferences.getInstance();
    user.name = _sharedPreferences.getString('userName') ?? '';
    user.age = _sharedPreferences.getInt('userAge') ?? 0;
    user.ative = _sharedPreferences.getBool('userAtive') ?? false;
    _darkTheme = _sharedPreferences.getBool('darkTheme') ?? false;
    final languageCode = _sharedPreferences.getString('languageCode') ?? 'en';
    _locale = Locale(languageCode);

    print("Valor salvo em 'userAtive': ${_sharedPreferences.getBool('userAtive')}");


    notifyListeners();
  }

  
  Future<void> setUserName(String name) async {
    await _sharedPreferences.setString('userName', name);
    user.name = name;
  }

  Future<void> setUserAge(int age) async {
    await _sharedPreferences.setInt('userAge', age);
    user.age = age;
  }

  Future<void> setUserAtive(bool ative) async{
    await _sharedPreferences.setBool('userAtive', ative);
    user.ative = ative;
  }

  Future<void> setUserData(String name, int age, bool ative) async {
    await setUserName(name);
    await setUserAge(age);
    await setUserAtive(ative);
    notifyListeners();
  }


  Future<void> toggleTheme(bool isDark) async {
    _darkTheme = isDark;
    await _sharedPreferences.setBool('darkTheme', isDark);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    await _sharedPreferences.setString('languageCode', languageCode);
    notifyListeners();
  }

  Future<void> clearUserData() async {
    await _sharedPreferences.remove('userName');
    await _sharedPreferences.remove('userAge');
    await _sharedPreferences.remove('userAtive');
    notifyListeners();
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier{


  late String _userName;
  late int _userAge;
  var _darkTheme = false;


  String get userName => _userName;
  int get userAge => _userAge;
  get darkTheme => _darkTheme;


  set userAge(int value) {
    _userAge = value;
  }
  set userName(String value) {
    _userName = value;
  }


  set darkTheme(value) {
    _darkTheme = value;
  }



  late SharedPreferences _sharedPreferences;

  //starting up the sharedPreferences
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _userName = _sharedPreferences.getString('userName') ?? '';
    _userAge = _sharedPreferences.getInt('userAge') ?? 0;
    _darkTheme = _sharedPreferences.getBool('darkTheme') ?? false;
    notifyListeners();
  }
  
  Future<void> setUserName(String name) async {
    _userName = name;
    await _sharedPreferences.setString('userName', name);
    notifyListeners();
  }

  Future<void> setUserAge(int age) async {
    _userAge = age;
    await _sharedPreferences.setInt('userAge', age);
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _darkTheme = isDark;
    await _sharedPreferences.setBool('darkTheme', isDark);
    notifyListeners();
  }

  Future<void> clearUserData() async {
    await _sharedPreferences.remove('userName');
    await _sharedPreferences.remove('userAge');
    _userName = '';
    _userAge = 0;
    notifyListeners();
  }

}
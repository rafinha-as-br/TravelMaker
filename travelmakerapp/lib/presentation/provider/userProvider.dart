import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/entities/user.dart';

import '../../l10n/app_localizations.dart';

class UserProvider extends ChangeNotifier{

  var _darkTheme = false;
  get darkTheme => _darkTheme;
  int languageN = 0;
  CountryFlag countryFlag = CountryFlag.fromLanguageCode('pt-BR', width: 50, height: 30);

  DateTime getDate(){
    DateTime dateToday = DateTime.now();
    return dateToday;
  }

  UserProvider(){
    init();
  }

  set darkTheme(value) {
    _darkTheme = value;
  }

  String getFormatedDate(){
    String formatedDate = DateFormat('dd/MM/yyyy').format(getDate());
    return formatedDate;
  }

  String getGreeting(DateTime date, BuildContext context) {
    String greeting;
    if (date.hour >= 0 && date.hour < 12) {
      greeting = AppLocalizations.of(context)!.goodMorning;
    } else if (date.hour >= 12 && date.hour < 18) {
      greeting = AppLocalizations.of(context)!.goodAfternon;
    } else {
      greeting = AppLocalizations.of(context)!.goodNight;
    }
    return greeting;
  }

  Locale _locale = const Locale('pt');
  Locale get locale => _locale;

  //create an empty user and goes to be updated on setUserName and SetUserAge
  User user = User(null, null, false, null);

  late SharedPreferences _sharedPreferences;

  //starting up the sharedPreferences
  Future<void> init() async {



    _sharedPreferences = await SharedPreferences.getInstance();
    user.name = _sharedPreferences.getString('userName') ?? '';
    user.age = _sharedPreferences.getInt('userAge') ?? 0;
    user.ative = _sharedPreferences.getBool('userAtive') ?? false;
    _darkTheme = _sharedPreferences.getBool('darkTheme') ?? false;
    final languageCode = _sharedPreferences.getString('languageCode') ?? 'pt';
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


  Future<void> getLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    await _sharedPreferences.setString('languageCode', languageCode);
    notifyListeners();
  }

  Future<void> setLanguage () async{
    if(languageN == 2){
      languageN = 0;
    } else{
      languageN++;
    }

    switch (languageN){
      case 0:
        await getLanguage('pt');
        countryFlag = CountryFlag.fromLanguageCode('pt-BR', width: 50, height: 30,);
      case 1:
        await getLanguage('en');
        countryFlag = CountryFlag.fromLanguageCode('en-US', width: 50, height: 30);
      case 2:
        await getLanguage('es');
        countryFlag = CountryFlag.fromLanguageCode('es', width: 50, height: 30);
    }
  }



  Future<void> clearUserData() async {
    await _sharedPreferences.remove('userName');
    await _sharedPreferences.remove('userAge');
    await _sharedPreferences.remove('userAtive');
    notifyListeners();
  }


}
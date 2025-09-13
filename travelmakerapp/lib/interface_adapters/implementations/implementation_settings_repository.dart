
import 'dart:ui';

import 'package:flutter/src/material/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/repository_settings.dart';

class SettingsRepositoryImpl implements SettingsRepository{
  SharedPreferences _preferences;
  SettingsRepositoryImpl(this._preferences);

  @override
  Future<Validator> removeSettingsSharedPreferences() async{
    // this function is only used in remove user function
    final removeLocale = await _preferences.remove('locale');
    if(removeLocale == false){
      return Validator(false, 'Error on removing locale from sharedPreferences');
    }

    final removeTheme = await _preferences.remove('theme');
    if(removeTheme == false){
      return Validator(false, 'Error on removing theme from sharedPreferences');
    }

    return Validator(true, null);
  }



  @override
  (Validator, ThemeMode?) getCurrentTheme() {
    final int? themeIndex = _preferences.getInt('theme');
    if (themeIndex == null){
      return (Validator(false, 'error on getting the themeIndex'), null);
    }
    return (Validator(true, null) ,ThemeMode.values[themeIndex]);
  }

  @override
  (Validator, Locale?) getCurrentLocale() {
    final String? localeStr = _preferences.getString('locale');
    if (localeStr == null) {
      return (Validator(false, 'Locale not found'), null);
    }

    final parts = localeStr.split('_');
    final languageCode = parts.first;

    return (Validator(true, null), Locale(languageCode));
  }


  @override
  Future<Validator> saveLocaleSharedPrefences(Locale locale) async{
    final saveLocale = await _preferences.setString('locale', locale.toString());
    if(saveLocale == false){
      return Validator(false, 'Error on saving locale in sharedPreferences');
    }
    return Validator(true, null);
  }

  @override
  Future<Validator> saveThemeSharedPreferences(ThemeMode theme) async{

    final saveTheme = await _preferences.setInt('theme', theme.index);
    if(saveTheme == false){
      return Validator(false, 'Erro on saving theme in sharedPreferences');
    }
    return Validator(true, null);
  }


  
}



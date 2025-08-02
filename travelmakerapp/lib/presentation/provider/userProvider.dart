import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/usecase/languages/getFlag.dart';
import 'package:travelmakerapp/usecase/location/getLocale.dart';
import 'package:travelmakerapp/usecase/pickImageFromGallery.dart';
import 'package:travelmakerapp/usecase/sharedPreferences/clearUserData.dart';
import 'package:travelmakerapp/usecase/sharedPreferences/set_userData.dart';
import 'package:travelmakerapp/usecase/sharedPreferences/sharedStartUp.dart';
import '../../usecase/sharedPreferences/sharedPreferencesInstance.dart';

class UserProvider extends ChangeNotifier{

  int languageN = 0;
  CountryFlag countryFlag = getFlag('pt-BR');
  bool _initialized = false;


  UserProvider(){
    init();
  }

  //create an empty user and goes to be updated on setUserName and SetUserAge
  User user = User(null, null, false, false, 'pt', Locale('pt'), null);


  //starting up the sharedPreferences
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    await SharedPreferencesInstance().init();
    await SharedStartUp(user);
    if(getLocale() == null){
      user.locale = Locale('${user.language}');
    }


    notifyListeners();
  }

  // this function is used on the userForm
  Future<void> createUser(String name, int age, bool ative) async{
    await setUserData(user, name, age, ative);
    notifyListeners();
  }

  // this function is used only to delete user in user & configs
  Future<void> removeUser() async{
    await clearUserData(user);
    notifyListeners();
  }

  Future<void> changeLanguage() async{
    if(languageN == 2){
      languageN = 0;
    } else{
      languageN++;
    }
    switch(languageN){
      case 0:
        await setUserLanguage(user, 'pt');
        countryFlag = getFlag('pt-BR');
      case 1:
        await setUserLanguage(user, 'en' );
        countryFlag = getFlag('en-US');
      case 2:
        await setUserLanguage(user, 'es');
        countryFlag = getFlag('es');

    }
    notifyListeners();
  }

  Future<void> changeTheme(bool isDark) async{
    await setUserTheme(user, isDark);
    notifyListeners();
  }


  Future<void> changeProfilePicture() async{
    await setUserProfilePicPath(user);
    notifyListeners();
  }


}
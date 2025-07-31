
import 'package:country_flags/country_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/usecase/sharedPreferences/set_userData.dart';

import '../../entities/user.dart';

Future<void> toggleLanguage(User user,int languageN, CountryFlag countryFlag, SharedPreferences sharedPreferences) async{
  if(languageN == 2){
    languageN = 0;
  } else{
    languageN++;
  }

  switch(languageN){
    case 0:
      await setUserLanguage(user, 'pt', sharedPreferences);
      countryFlag = CountryFlag.fromLanguageCode('pt-BR', width: 60, height: 30,);
    case 1:
      await setUserLanguage(user, 'en', sharedPreferences);
      countryFlag = CountryFlag.fromLanguageCode('en-US', width: 60, height: 30);
    case 2:
      await setUserLanguage(user, 'es', sharedPreferences);
      countryFlag = CountryFlag.fromLanguageCode('es', width: 60, height: 30);

  }

}
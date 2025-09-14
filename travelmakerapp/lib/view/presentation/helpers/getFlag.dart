// this function return a custom flag based on a string parameter

import 'package:country_flags/country_flags.dart';

CountryFlag getFlag(String localeStr){
  String languageCode = localeStr.split('_')[0];
  if(languageCode == 'pt'){
    languageCode = 'pt-BR';
  }
  return CountryFlag.fromLanguageCode(
    languageCode,
    width: 70,
    height: 50,
    shape: const RoundedRectangle(13),
  );
}

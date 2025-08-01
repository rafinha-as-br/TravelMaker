// this function return a custom flag based on a string parameter

import 'package:country_flags/country_flags.dart';

CountryFlag getFlag(String countryCode){
  CountryFlag countryFlag = CountryFlag.fromLanguageCode(
    countryCode,
    width: 70,
    height: 35,
    shape: const RoundedRectangle(15),
  );
  return countryFlag;
}
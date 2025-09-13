import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import 'getDate.dart';


// file that contains string formatation of dates and related

/// this function is used in homeScreen_title
String getFormatedDate1(){
  String formatedDate1 = DateFormat('dd/MM/yyyy').format(getDate());
  return formatedDate1;
}


String getFormatedDate2(DateTime date){
  String formatedDate1 = DateFormat('dd/MM/yyyy').format(date);
  return formatedDate1;
}

String getGreeting(BuildContext context) {
  DateTime date = getDate();
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
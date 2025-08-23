import 'package:flutter/cupertino.dart';

import '../../../l10n/app_localizations.dart';

String getErrorString(String string, BuildContext context) {
  String errorText = '';

  switch (string) {
    case 'titleEmpty':
      errorText =  AppLocalizations.of(context)!.errorTitleEmpty;
    case 'titleShort':
      errorText =  AppLocalizations.of(context)!.errorTitleShort;
    case 'descriptionEmpty':
      errorText =  AppLocalizations.of(context)!.errorDescriptionEmpty;
    case 'descriptionShort':
      errorText =  AppLocalizations.of(context)!.errorDescriptionShort;
    case 'cityEmpty':
      errorText =  AppLocalizations.of(context)!.errorCityEmpty;
    case 'vehicleNotSected':
      errorText =  AppLocalizations.of(context)!.errorVehicleNotSelected;
    case 'datesNotSelected':
      errorText = AppLocalizations.of(context)!.errorDatesNotSelected;
    case 'departureDateBeforeToday':
      errorText =  AppLocalizations.of(context)!.errorDepartureDateBeforeToday;
    case 'arrivalDateBeforeDeparture':
      errorText =  AppLocalizations.of(context)!.errorArrivalDateBeforeDeparture;
    case 'personNameEmpty':
      errorText =  AppLocalizations.of(context)!.errorPersonNameEmpty;
    case 'personNameShort':
      errorText =  AppLocalizations.of(context)!.errorPersonNameShort;
    case 'notNumber':
      errorText =  AppLocalizations.of(context)!.errorPersonAgeEmpty;
    case 'invalidCoordinates':
      errorText = 'you need to select a city!';
  }
  return errorText;
}

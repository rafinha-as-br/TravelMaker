
import 'package:flutter/cupertino.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

import '../../../l10n/app_localizations.dart';

String getVehicleName(Vehicles vehicle, BuildContext context){
  switch (vehicle){
    case Vehicles.car:
      return AppLocalizations.of(context)!.car;
    case Vehicles.bus:
      return AppLocalizations.of(context)!.bus;
    case Vehicles.train:
      return AppLocalizations.of(context)!.train;
    case Vehicles.boat:
      return AppLocalizations.of(context)!.boat;
    case Vehicles.airplane:
      return AppLocalizations.of(context)!.airplane;
    case Vehicles.notSelected:
      return AppLocalizations.of(context)!.notSelected;
  }

}
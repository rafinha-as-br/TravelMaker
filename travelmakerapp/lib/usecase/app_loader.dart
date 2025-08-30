import 'package:geolocator/geolocator.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/interface_adapters/repositories/location_service.dart';
import 'package:travelmakerapp/view/database/database.dart';

import '../interface_adapters/repositories/user_repository.dart';

/// checks if the user is active from SharedPrefs and send a validator signal
Future<Validator> user_app_loader() async{
  // instance from sharedPreferences
  UserRepository userInstance = UserRepository();
  User user = await userInstance.getCurrentUser();
  if(!user.active){
    return Validator(false, 'User not inicializated');
  }
  return Validator(true, null);

}

/// check if the gps is active,
/// if the user autorizes the GPS, continue
/// if the user blocks the gpt, open another screen that solicitates the GPS again
Future<Validator> gps_app_loader(Location_Service locationService) async{
  bool serviceEnabled = await locationService.isServiceEnabled();
  if (!serviceEnabled){
    return Validator(false, 'Location service not enabled');
  }

  LocationPermission permission = await locationService.checkPermission();
  if(permission == LocationPermission.denied){
    //get the localizationPermission denied for the first time
    permission = await locationService.requestPermission();
    if(permission == LocationPermission.denied){
      return Validator(false, 'LocationPermissionDenied');
    }
    if(permission == LocationPermission.deniedForever){
      return Validator(false, 'LocationPermissionDeniedForever');
    }

  }

  return Validator(true, null);

  
}

Future<Validator> dataBase_loader() async{
  final db = await AppDatabase.instance.database;
  if(!db.isOpen){
    return Validator(false, 'DataBaseInitError');
  }
  return Validator(true, null);
}
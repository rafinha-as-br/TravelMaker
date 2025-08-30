import 'package:travelmakerapp/entities/appState.dart';
import '../entities/validator.dart';


Future <(AppStatus, Validator)> app_loader (
    Future<Validator> Function() gps_app_loader,
    Future<Validator> Function() dataBase_loader,
    Future<Validator> Function() user_loader,
    ) async
{
  Validator userLoader = await user_loader();
  if(!userLoader.success){
    return (AppStatus.userNotInSharedPrefs, userLoader);
  }
  Validator gpsLoader = await gps_app_loader();
  if(!gpsLoader.success){
    return (AppStatus.needGPS, gpsLoader);
  }
  Validator dataBaseLoader = await dataBase_loader();
  if(!dataBaseLoader.success){
    return (AppStatus.errorDatabase, dataBaseLoader);
  }
  return (AppStatus.ready, Validator(true, null));



}
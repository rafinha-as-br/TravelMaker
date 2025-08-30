
//this provider manages the overall state of the all, it is responsible for
// check the inicial state of the app, check API status etc...
import 'package:flutter/widgets.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/app_loader.dart';

import '../repositories/location_service.dart';

enum AppStatus{initializing, needGPS, needUser, errorDatabase, ready}


class AppStateProvider with ChangeNotifier{
  AppStatus appStatus = AppStatus.initializing;

  Future<Validator> initializeApp() async{

    // check the location service status
    Location_Service locationService = Location_Service();
    final gpsstatus = await gps_app_loader(locationService);
    if(!gpsstatus.success){
      appStatus = AppStatus.needGPS;
      return gpsstatus;
    }

    /// checks if there is an used active
    final hasUser = await user_app_loader();
    if(!hasUser.success){

      appStatus = AppStatus.needUser;
      return hasUser;
    }

    final dataBaseInitStatus = await dataBase_loader();
    if(!dataBaseInitStatus.success){
      return dataBaseInitStatus;
    }

    appStatus = AppStatus.ready;
    return Validator(true, null);

  }


}
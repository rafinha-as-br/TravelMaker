//this provider manages the overall state of the all, it is responsible for
// check the inicial state of the app, check API status etc...
import 'package:country_flags/country_flags.dart';
import 'package:flutter/widgets.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/app_loader.dart';

import '../../view/presentation/helpers/getFlag.dart';
import '../repositories/location_service.dart';
import '../repositories/user_repository.dart';

//enum to define the application state
enum AppStatus{initializing, needGPS, needUser, errorDatabase, ready}

// this provider controls the application state and user data
class AppStateProvider with ChangeNotifier{

  //----------- variable for controling the application state------------------
  AppStatus appStatus = AppStatus.initializing;

  // this function is used in appLoaderScreen, it verificates if the basic needings
  // of this app and sets the application status
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
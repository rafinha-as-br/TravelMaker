//this provider manages the overall state of the all, it is responsible for
// check the inicial state of the app, check API status etc...
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/app_loader.dart';
import 'package:travelmakerapp/usecase/create_user.dart';

import '../../entities/appState.dart';
import '../../entities/user.dart';
import '../../view/database/database.dart';
import '../implementations/location_service.dart';
import '../implementations/user_repository.dart';

//enum to define the application state

// this provider controls the application state and user data
class AppStateProvider with ChangeNotifier{
  final UserRepositoryImpl userRepo;

  AppStateProvider(this.userRepo);



  //----------- variable for controling the application state------------------
  AppStatus appStatus = AppStatus.initializing;
  // for default values use the initializing mode because he will return the loading screen


  // this function is used in appLoaderScreen, it verificates if the basic needings
  // of this app and sets the application status
  Future<Validator> initializeApp() async{

    final appLoader = await app_loader(
        user_loader,
        gps_app_loader,
        dataBase_loader
    );

    appStatus = appLoader.$1;
    notifyListeners();
    return appLoader.$2;

  }


  Future<Validator> user_loader() async{
    User user = await userRepo.getCurrentUser();


    if(!user.active){
      return Validator(false, 'UserNotActiveShared');
    }
    return Validator(true, null);

  }

  Future<Validator> gps_app_loader() async{
      /// check if the gps is active,
      /// if the user autorizes the GPS, continue
      /// if the user blocks the gps, open another screen that solicitates the GPS again

      LocationServiceImpl locationService = LocationServiceImpl();
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

  //------------------------- User Variables -----------------------------------

  final nameController = TextEditingController();
  final ageController = TextEditingController();


  //------------------------- User methods -------------------------------------
  void clearControllers(){
    nameController.clear();
    ageController.clear();
    notifyListeners();
  }

   (Validator, User?) createUser() {

    //call the createUser implementation


    User user = User(
        nameController.text,
        int.tryParse(ageController.text) ?? 0,
        null
    );

    final validateUser = create_user(user, userRepo);
    if(!validateUser.success){
      return (validateUser, null);
    }

    return (Validator(true, null), user);

    // with this function, the screen can

  }



}


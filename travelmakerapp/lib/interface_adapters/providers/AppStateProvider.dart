//this provider manages the overall state of the all, it is responsible for
// check the inicial state of the app, check API status etc...
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/app_loader.dart';
import 'package:travelmakerapp/usecase/create_user.dart';
import 'package:travelmakerapp/usecase/get_current_user.dart';
import 'package:travelmakerapp/usecase/remove_user.dart';
import 'package:travelmakerapp/usecase/repositories/location_service_Impl.dart';
import 'package:travelmakerapp/usecase/set_user_profile_picture.dart';
import 'package:travelmakerapp/usecase/update_user.dart';

import '../../entities/appState.dart';
import '../../entities/user.dart';
import '../implementations/user_repository.dart';

// this provider controls the application state and user data
class AppStateProvider with ChangeNotifier{
  final UserRepositoryImpl userRepo;
  final Database db;
  final LocationService locationService;

  AppStateProvider(this.userRepo, this.db, this.locationService);



  //----------- variables for controling the application state------------------

  AppStatus appStatus = AppStatus.initializing;
  // for default values use the initializing mode because he will return the loading screen

  Future<Validator> initializeApp() async{
    // this function is used in appLoaderScreen, it verificates if the basic needings
    // of this app and sets the application status

    final appLoader = await appLoaderUseCase(locationService, userRepo);

    appStatus = appLoader.$1;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 4));
    return appLoader.$2;

  }





  //------------------------- User Variables -----------------------------------

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  final editNameController = TextEditingController();
  final editAgeController = TextEditingController();
  String? profilePicture;




  bool editMode = false;

  //------------------------- User Variables methods ---------------------------
  void clearControllers(){
    nameController.clear();
    ageController.clear();
    editNameController.clear();
    editAgeController;


    editMode = false;
    notifyListeners();
  }

  //------------------------- User methods -------------------------------------

  Future<Validator> createUser() async{
    //creates a user and call the createUserUseCase

    User user = User(
        nameController.text,
        int.tryParse(ageController.text) ?? 0
    );

    //call the createUser useCase
    final validateUser = await createUserUseCase(user, userRepo);
    if(!validateUser.success){
      return validateUser;
    }

    return Validator(true, null);

  }

  Future<Validator> removeUser() async{
    final removeUser = await removeUserUseCase(userRepo);
    if(!removeUser.success){
      return removeUser;
    }

    return Validator(true, null);
  }

  Future<User?> getUser() async{
    final user = await getCurrentUserUseCase(userRepo);
    return user;
  }

  Future<void> setControllers(User user) async{
    editMode = true;
    editNameController.text = user.name;
    editAgeController.text = user.age.toString();
    print(editAgeController.text);
    profilePicture = user.profilePicturePath;
    notifyListeners();
}

  Future<Validator> updateUser() async{

    User? currentUser = await getCurrentUserUseCase(userRepo);
    int? id = currentUser!.userID;

    User newUser = User(
        editNameController.text,
        int.tryParse(editAgeController.text)?? 0,

    )..profilePicturePath = profilePicture ..userID = id;
    final updateUser = await updateUserUseCase(userRepo, newUser);

    if(!updateUser.success){
      return updateUser;
    }

    return Validator(true, null);


  }

  //get a picture and saves it
  selectProfilePicture() async {

    //getting the picture and updating the profilePicture path inside this provider
    profilePicture = await setUserProfilePictureUseCase(userRepo);

    notifyListeners();

  }

}


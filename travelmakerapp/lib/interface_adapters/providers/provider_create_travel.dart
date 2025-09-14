import 'package:flutter/material.dart';

import '../../entities/Travel.dart';
import '../../entities/destination.dart';
import '../../entities/experience.dart';
import '../../entities/finish.dart';
import '../../entities/origin.dart';
import '../../entities/person.dart';
import '../../entities/travelStop.dart';
import '../../entities/validator.dart';
import '../../entities/vehicles.dart';
import '../../usecase/create_travel.dart';
import '../../usecase/get_current_user.dart';
import '../../usecase/repositories/repository_person.dart';
import '../../usecase/repositories/repository_travel.dart';
import '../../usecase/repositories/repository_travel_stop.dart';
import '../../usecase/repositories/repository_user.dart';
import '../controllers/stop_form_controller.dart';
import '../controllers/travel_form_controller.dart';

/// controls the TravelFormController and StopFormController, calls
/// all the necessary useCase and only exists in createTravelScreen & further
/// screens
class CreateTravelProvider with ChangeNotifier{
  /// user repository
  UserRepository userRepo;

  /// travel repository
  TravelRepository travelRepo;

  /// stop repository
  StopRepository stopRepo;

  /// person repository
  PersonRepository personRepo;

  /// default constructor
  CreateTravelProvider(
      this.userRepo,
      this.travelRepo,
      this.stopRepo,
      this.personRepo
  ) {
    tfc = TravelFormController();
    sfc = StopFormController();
  }

  @override
  void dispose() {
    tfc.disposeTravelControllers();
    sfc.dispose();
    super.dispose();
  }

  /// travelFormController - Used here as tfc to not get long lines
  /// (the controllers names are already big enough)
  late TravelFormController tfc;

  /// stopFormController - Used here as sfc to not get long lines
  /// (the controllers names are already big enough)
  late StopFormController sfc;


  // ---------------------------- GENERAL METHODS ------------------------------


  /// TODO THIS METHODS NEEDS TO GET OUT OF HERE AND
  /// PASSED TO THEIR ESPECIFIC WIDGETS
  bool isDatesSelected({required bool date1, required bool date2}){
    if(date1 == true && date2 == true){
      return true;
    } else{
      return false;
    }
  }

  /// TODO THIS METHODS NEEDS TO GET OUT OF HERE AND
  /// PASSED TO THEIR ESPECIFIC WIDGETS
  int daysSpent(DateTime startDate, DateTime finalDate){
    int timeSpent;
    timeSpent = finalDate.difference(startDate).inDays;
    return timeSpent;

  }

  // ------------------------- TRAVEL VARIABLES  -------------------------------
  // * used for storage or controlling the state of the provider

  ///stores the persons of this travel
  List<Person> travelPersonsList = [];

  /// stores the stops of this travel
  List<TravelStop> travelStopList = [];

  ///stores the experiences of this travel
  List<Experiences> experiencesList = [];

  ///vehicle chosen
  Vehicles vehicleChosen = Vehicles.notSelected;

  /// boolean used in vehiclesExpansion tile
  bool isVehicleExpanded = true;

  /// int for checking if the user is added to the travel for in time of
  /// rebuilding the screen doesn't add the user multiple times at a stop
  bool userAdded = false;


  // ------------------ TRAVEL METHODS -----------------------------------------

  //-- travel vehicles enum methods

  /// to retract the vehicles selector when on is selected
  void toggleVehicleExpanded({required bool expanded}) {
    isVehicleExpanded = expanded;
    notifyListeners();
  }

  /// to select a vehicle and update the vehicleChosen
  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }

  //-- travel personsList methods --

  /// to update or add a person inside TravelPersonsList
  void updatePersonsList(Person person, {int? index}) {
    if (index != null) {
      travelPersonsList[index] = person;
    } else {
      travelPersonsList.add(person);
    }
    notifyListeners();
  }

  /// add the user to the TravelPersonsList
  Future<void> addUserToPersonList() async{
    final user = await getCurrentUserUseCase(userRepo);

    updatePersonsList(
        Person(
            name: user!.name,
            age: user.age,
            preferredVehicle: vehicleChosen
        )
    );
    notifyListeners();
  }

  /// to remove a person inside travelPersonsList by index
  void removePerson(int index){
    travelPersonsList.removeAt(index);
    notifyListeners();
  }

  // -- create travel methods --

  /// to create a travel
  Future<Validator> createTravel() async{
    // throw to Travel and validates by the rules in that file, if validator
    // return (true and null) => Add travel to User and DataBase!
    // Return to homePage!
    // if not, throw an dialog

    if(tfc.departure == null || tfc.arrival == null){
      return Validator(false, 'datesNotSelected');

    } else{
      try{
        // origin - Where the travel starts
        final origin = Origin(
            city: tfc.travelOriginCityController.text,
            latitude: num.tryParse(tfc.travelOriginLatController.text) ?? 0,
            longitude: num.tryParse(tfc.travelOriginLongController.text) ?? 0,
            departureDate: tfc.departure!,
            passed: false
        );

        // finish - Where the travel ends
        final finish = Finish(
            city: tfc.travelFinishCityController.text,
            latitude: num.tryParse(tfc.travelFinishLatController.text)?? 0,
            longitude: num.tryParse(tfc.travelOriginLongController.text)?? 0,
            arrivalDate: tfc.arrival!,
            passed: false
        );

        // creating travel...
        final travel = Travel(
            tfc.travelTitleController.text,
            tfc.travelDescriptionController.text,
            origin,
            finish,
            vehicleChosen,
            travelStopList,
            travelPersonsList,
            experiencesList
        );

        return await createTravelUseCase(
            travel,
            travelRepo,
            userRepo,
            stopRepo,
            personRepo);

      } catch(e){
        return Validator(false, 'Error on creating the travel');
      }

    }
  }

  /// to reset all the related data inside the provider before
  void clearTravelData(){
    vehicleChosen = Vehicles.notSelected;
    travelStopList.clear();
    userAdded = false;
    travelPersonsList.clear();
  }

  //-- TODO update travel methods --

  //Future<Validator> updateTravel() async{}

  //-- travel experience methods --

  /// method to add/remove the experiences to the experiencesList
  void updateExperienceList(Experiences experience){
    if(experiencesList.contains(experience)){
      experiencesList.remove(experience);
    } else{
      experiencesList.add(experience);
    }
    notifyListeners();
  }

  // ------------------ STOP VARIABLES -----------------------------------------

  /// boolean to verify if the user is editing a stop
  bool isEditingStop = false;

  /// index to verify what stop is being edited
  int? stopEditIndex;

  // ------------------ STOP METHODS -------------------------------------------

  /// -- create stop methods --

  /// to create a stop
  Validator createStop(){
    try{
      final destination = Destination(
          sfc.stopDestinationController.text,
          double.tryParse(sfc.stopDestinationLatitude.text)?? 0,
          double.tryParse(sfc.stopDestinationLongitude.text) ?? 0,

      );

      final stop = TravelStop(
          arrival: sfc.stopArrivalDate,
          departure: sfc.stopDepartureDate,
          destination: destination,
          description: sfc.stopDestinationController.text
      );


      final stopValidate = stop.validateStop(stop);
      if(!stopValidate.success){
        return stopValidate;
      }

      if(isEditingStop == false){
        travelStopList.add(stop);
        clearStopData();
      } else{
        travelStopList[stopEditIndex!] = stop;
        isEditingStop = false;

      }

      notifyListeners();
      return Validator(true, null);
    } catch (e){
      return Validator(false, 'Error on creating or editing the stop');
    }


  }

  /// clear all the data from the stop controllers
  void clearStopData(){
    sfc.clearStopControllers();
    stopEditIndex = null;
    isEditingStop = false;
  }


  /// to set the controllers and variables to receive their values from a stop
  void setStopEdit(int index, BuildContext context){
    clearStopData();
    isEditingStop = true;
    sfc.setStopEdit(travelStopList[index], context);

    notifyListeners();
  }

}
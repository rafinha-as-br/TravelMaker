import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/destination.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/origin.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import 'package:travelmakerapp/interface_adapters/controllers/stop_form_controller.dart';
import 'package:travelmakerapp/interface_adapters/controllers/travel_form_controller.dart';
import 'package:travelmakerapp/usecase/create_travel.dart';
import 'package:travelmakerapp/usecase/get_current_user.dart';
import 'package:travelmakerapp/usecase/repositories/person_repository_database.dart';
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';
import '../../entities/finish.dart';
import '../../entities/validator.dart';
import '../../usecase/repositories/stop_repository.dart';
import '../../usecase/repositories/travel_repository.dart';

class CreateTravelProvider with ChangeNotifier{
  UserRepository userRepo;
  TravelRepository travelRepo;
  StopRepository stopRepo;
  PersonRepository personRepo;

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


  // THIS METHODS NEEDS TO GET OUT OF HERE AND PASSED TO THEIR ESPECIFIC WIDGETS

  bool isDatesSelected(bool date1, bool date2){
    if(date1 == true && date2 == true){
      return true;
    } else{
      return false;
    }
  }

  int daysSpent(DateTime startDate, DateTime finalDate){
    int timeSpent;
    timeSpent = finalDate.difference(startDate).inDays;
    return timeSpent;

  }

  // ------------------------- TRAVEL VARIABLES  -------------------------------
  // * used for storage or controlling the state of the provider

  //stores the persons of this travel
  List<Person> travelPersonsList = [];

  // stores the stops of this travel
  List<TravelStop> travelStopList = [];

  //stores the experiences of this travel
  List<Experiences> experiencesList = [];

  //vehicle chosen
  Vehicles vehicleChosen = Vehicles.notSelected;

  // boolean used in vehiclesExpansion tile
  bool isVehicleExpanded = true;
  int? travelEditIndex;
  bool userAdded = false;


  // ------------------ TRAVEL METHODS -----------------------------------------

  //-- travel vehicles enum methods
  void toggleVehicleExpanded(bool expanded) {
    isVehicleExpanded = expanded;
    notifyListeners();
  }
  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }

  //-- travel personsList methods --
  void updatePersonsList(Person person, {int? index}) {
    if (index != null) {
      travelPersonsList[index] = person;
    } else {
      travelPersonsList.add(person);
    }
    notifyListeners();
  }

  Future<void> addUserToPersonList() async{
    final user = await getCurrentUserUseCase(userRepo);

    updatePersonsList(Person(name: user!.name, age: user.age, preferredVehicle: vehicleChosen));
    notifyListeners();
  }

  void removePerson(index){
    travelPersonsList.removeAt(index);
    notifyListeners();
  }

  // -- create travel methods --
  Future<Validator> createTravel() async{
    // throw to Travel and validates by the rules in that file, if validator
    // return (true and null) => Add travel to User and DataBase! Return to homePage!
    // if not, throw an dialog

    if(tfc?.departure == null || tfc?.arrival == null){
      return Validator(false, "datesNotSelected");

    } else{
      try{
        // origin - Where the travel starts
        Origin origin = Origin(
            city: tfc!.travelOriginCityController.text,
            latitude: num.tryParse(tfc!.travelOriginLatController.text) ?? 0,
            longitude: num.tryParse(tfc!.travelOriginLongController.text) ?? 0,
            departureDate: tfc!.departure!,
            passed: false
        );

        // finish - Where the travel ends
        Finish finish = Finish(
            city: tfc!.travelFinishCityController.text,
            latitude: num.tryParse(tfc!.travelFinishLatController.text)?? 0,
            longitude: num.tryParse(tfc!.travelOriginLongController.text)?? 0,
            arrivalDate: tfc!.arrival!,
            passed: false
        );

        // creating travel...
        Travel travel = Travel(
            tfc!.travelTitleController.text,
            tfc!.travelDescriptionController.text,
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

  void clearTravelData(){
    tfc.clearTravelControllers();
    vehicleChosen = Vehicles.notSelected;
    travelStopList.clear();
    userAdded = false;
    travelPersonsList.clear();
  }

  //-- update travel methods --

  Future<Validator> updateTravel() async{}

  //-- travel experience methods --
  void updateExperienceList(Experiences experience){
    if(experiencesList.contains(experience)){
      experiencesList.remove(experience);
    } else{
      experiencesList.add(experience);
    }
    notifyListeners();
  }

  // ------------------ STOP VARIABLES -----------------------------------------

  bool isEditingStop = false;
  int? stopEditIndex;

  // ------------------ STOP METHODS -------------------------------------------

  // -- create stop methods --
  Validator createStop(){
    try{
      Destination destination = Destination(
          sfc!.stopDestinationController.text,
          double.tryParse(sfc!.stopDestinationLatitude.text)?? 0,
          double.tryParse(sfc!.stopDestinationLongitude.text) ?? 0,

      );

      TravelStop stop = TravelStop(
          sfc!.stopArrivalDate,
          sfc!.stopDepartureDate,
          destination,
          sfc!.stopDestinationController.text,
      );

      Validator stopValidate = stop.validateStop(stop);
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

  // clear all the data from the stop controllers
  void clearStopData(){
    sfc!.clearStopControllers();
    stopEditIndex = null;
    isEditingStop = false;
  }


  // to set the controllers and variables to receive their values from a stop
  void setStopEdit(int index, BuildContext context){
    clearStopData();
    isEditingStop = true;
    sfc!.setStopEdit(travelStopList[index], context);

    notifyListeners();
  }

}
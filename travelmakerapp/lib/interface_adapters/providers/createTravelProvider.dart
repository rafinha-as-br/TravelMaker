import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';
import '../../entities/finish.dart';
import '../../entities/validator.dart';
import '../../usecase/repositories/stop_repository.dart';
import '../../usecase/repositories/travel_repository.dart';
import '../../view/presentation/helpers/dates/getDate.dart';

class CreateTravelProvider with ChangeNotifier{
  UserRepository userRepo;
  TravelRepository travelRepo;
  StopRepository stopRepo;

  CreateTravelProvider(this.userRepo, this.travelRepo, this.stopRepo);

  /// travelFormController - Used here as tfc to not get long lines
  /// (the controllers names are already big enough)
  TravelFormController? tfc;

  // starting the travelController
  void initTravelController(){
    tfc = TravelFormController();
    notifyListeners();
  }

  // to clean the memory and close the travel controller
  void disposeTravelController(){
    tfc?.dispose();
    tfc = null;
    notifyListeners();
  }

  /// stopFormController - Used here as sfc to not get long lines
  /// (the controllers names are already big enough)
  StopFormController? sfc;

  //starting the stopController
  void initStopController(){
    sfc = StopFormController();
    notifyListeners();
  }

  // cleaning the stopController
  void disposeStopController(){
    sfc?.dispose();
    sfc = null;
    notifyListeners();
  }

  // ---------------------------- GENERAL METHODS ------------------------------
  // * that can be used for travel or stop


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


  // ------------------ TRAVEL METHODS -----------------

  //-- travel vehicles enum methods -- THIS WILL BE REMOVED, WILL BE SENT TO THE WIDGET
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

  // -- travel validator methods --
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
            tfc!.travelOriginCityController.text,
            num.tryParse(tfc!.travelOriginLatController.text) ?? 0,
            num.tryParse(tfc!.travelOriginLongController.text) ?? 0,
            tfc!.departure!,
            false
        );

        // finish - Where the travel ends
        Finish finish = Finish(
            tfc!.travelFinishCityController.text,
            num.tryParse(tfc!.travelFinishLatController.text)?? 0,
            num.tryParse(tfc!.travelOriginLongController.text)?? 0,
            tfc!.arrival!,
            false
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

        Validator createTravel = await createTravelUseCase(travel, travelRepo, userRepo, stopRepo);
        if(!createTravel.success){
          return createTravel;
        }


      } catch(e){
        return Validator(false, 'Error on creating the travel');
      }

      return Validator(true, null);

    }
  }

  void clearTravelData(){
    tfc?.clearTravelControllers();
    vehicleChosen = Vehicles.notSelected;
    travelStopList.clear();
    travelPersonsList.clear();
  }

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


  // -- stop validator methods --
  Validator validateStop(){
    Destination destination = Destination(
        sfc!.stopDestinationController.text,
        double.tryParse(sfc!.stopDestinationLatitude.text)?? 0,
        double.tryParse(sfc!.stopDestinationLongitude.text) ?? 0,

    );

    TravelStop stop = TravelStop(
      stopStartDate,
      stopFinalDate,
      destination,
      stopDescriptionController.text
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
  }
  // ----------------------------

  // clear all the data from the stop controllers *NEED TO CALL THE STOP CLEAR CONTROLLERS()
  void clearStopData(){
    stopStartDate = null;
    stopFinalDate = null;
    stopDestinationLongitude.clear();
    stopDestinationLatitude.clear();
    stopDestinationController.clear();
    stopDescriptionController.clear();
    stopStartDateController.clear();
    stopFinalDateController.clear();
    stopEditIndex = null;
    isEditingStop = false;
  }

  // to set the controllers and variables to receive their values from a stop *NEED JUST TO PASS THE ESPECIFIC TRAVEL TO THE CONTROLLER FUNCTION SET STOP TO EDIT
  void setStopEdit(TravelStop stop, int index, BuildContext context){
    final locale = Localizations.localeOf(context).toString();
    clearStopData();
    isEditingStop = true;
    stopEditIndex = index;
    toggleStopDestinationController(stop.destination.city);
    stopDescriptionController.text = stop.description;
    stopDestinationLatitude.text = stop.destination.latitude.toString();
    stopDestinationLongitude.text = stop.destination.longitude.toString();

    stopStartDate = stop.arrival;
    stopStartDateController.text = DateFormat.yMd(locale).format(stop.arrival!);

    stopFinalDate = stop.departure;

    stopFinalDateController.text =  DateFormat.yMd(locale).format(stop.departure!);

    notifyListeners();
  }

  //-----------------------------------------------------------------------------

}
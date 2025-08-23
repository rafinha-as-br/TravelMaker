import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import '../../entities/response.dart';
import '../../usecase/dates/getDate.dart';
import '../../usecase/sharedPreferences/sharedPreferencesInstance.dart';

class CreateTravelProvider with ChangeNotifier{

  // ---------------------------- GENERAL METHODS ------------------------------
  // * that can be used for travel or stop

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

  // ---------------------------------------------------------------------------


  // ------------------------ GET USER INFO METHODS ----------------------------

  Future<String> getUserName() async {
    String? name = sharedPreferences.getString('userName');
    return name ?? '';
  }
  Future<int> getUserAge() async {
    int? age = sharedPreferences.getInt('userAge');
    return age ?? 0;
  }
  final sharedPreferences = SharedPreferencesInstance().preferences;
  bool userAdded = false;

  // ---------------------------------------------------------------------------




  // ------------------------- TRAVEL VARIABLES  -------------------------------
  // * used for storage or controlling the state of the provider


  late DateTime? travelStartDate;
  late DateTime? travelFinalDate;

  late DateTime? stopStartDate;
  late DateTime? stopFinalDate;

  // Boolean to control if dates are selected or not
  bool datesSelectedTravelStart = false;
  bool datesSelectedTravelFinal = false;



  //stores the persons of this travel
  List<Person> travelPersonsList = [];

  // stores the stops of this travel
  List<TravelStop> travelStopList = [];

  //stores the experiences of this travel
  List<ExperiencesList> experiencesList = [];

  //vehicle chosen
  Vehicles vehicleChosen = Vehicles.notSelected;

  // boolean used in vehiclesExpasion tile
  bool isVehicleExpanded = true;

  int? stopEditIndex;
  int? travelEditIndex;
  bool isEditingStop = false;


  // ---------------------------------------------------------------------------


  // ---------------------- TRAVEL CONTROLLERS, FORMKEYS & METHODS -----------------

  final travelTitleController = TextEditingController();
  final travelDescriptionController = TextEditingController();
  final travelDestinationController = TextEditingController();

  final travelStartDateController = TextEditingController();
  final travelFinalDateController = TextEditingController();

  final GlobalKey<FormFieldState> travelTitleFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDescriptionFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDestinationFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelFinalDateFormKey = GlobalKey<FormFieldState>();

  //-- travel vehicles enum methods --
  void toggleVehicleExpanded(bool expanded) {
    isVehicleExpanded = expanded;
    notifyListeners();
  }
  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }
  // --------------------------

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
    final name = await getUserName();
    final age = await getUserAge();
    updatePersonsList(Person(name: name, age: age));
    notifyListeners();
  }
  void removePerson(index){
    travelPersonsList.removeAt(index);
    notifyListeners();
  }
  // ------------------------

  //--travel travel dates methods --
  Future<void> selectTravelStartDate(BuildContext context ) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);

      datesSelectedTravelStart = true;
      travelStartDateController.text = formattedDate;
      travelStartDate = selectedDate;

      notifyListeners();
    }

  }
  Future<void> selectTravelFinalDate(BuildContext context, ) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);


      travelFinalDateController.text = formattedDate;
      travelFinalDate = selectedDate;
      datesSelectedTravelFinal = true;

      notifyListeners();
    }

  }
  //--------------------------------

  // -- travel validator methods --
  Validator createTravel(){
    // throw to Travel and validates by the rules in that file, if validator
    // return (true and null) => Add travel to User and DataBase! Return to homePage!
    // if not, throw an dialog

    if(datesSelectedTravelStart == false || datesSelectedTravelFinal == false){
      return Validator(false, "datesNotSelected");

    } else{
      Travel travel = Travel(
          travelTitleController.text,
          travelDescriptionController.text,
          travelStartDate!,
          travelFinalDate!,
          vehicleChosen,
          travelStopList,
          travelPersonsList
      );

      Validator validator = travel.validateTravel(travel);
      if(!validator.success){
        return validator;
      }
      return Validator(true, null);

    }
    notifyListeners();
  }
  void clearTravelData(){
    error = null;
    travelTitleController.clear();
    travelDescriptionController.clear();
    travelStartDate = null;
    travelFinalDate = null;
    vehicleChosen = Vehicles.notSelected;
    travelStopList.clear();
    travelPersonsList.clear();
  }

  // ---------------------------------------------------------------------------



  // ------------------ STOP VARIABLES -----------------------------------------

  // Boolean to control if dates are selected or not
  bool datesSelectedStopStart = false;
  bool datesSelectedStopFinal = false;

  // ---------------------------------------------------------------------------


  // ------------------ STOP CONTROLLER, FORMKEYS & METHODS --------------------

  //-- stop Controllers --
  final stopDestination = TextEditingController();
  final stopStartDateController = TextEditingController();
  final stopFinalDateController = TextEditingController();
  final stopDestinationLatitude = TextEditingController();
  final stopDestinationLongitude = TextEditingController();
  //----------------------

  //-- stop formkeys --
  final GlobalKey<FormFieldState> stopDestinationFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stopStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stopFinalDateFormKey = GlobalKey<FormFieldState>();
  //-------------------

  //-- stop controllers methods --
  void toggleTravelDestinationController(String description){
    // (sets the travelDestinationController text equals the city that it gets selected on the suggestion)
    travelDestinationController.text = description;
    notifyListeners();
  }
  void toggleStopDestinationController(String description){
    stopDestination.text = description;
    notifyListeners();
  }
  //------------------------------

  //stop experience methods
  void updateExperienceList(ExperiencesList experience){
    if(experiencesList.contains(experience)){
      experiencesList.remove(experience);
    } else{
      experiencesList.add(experience);
    }
    notifyListeners();
  }


  //--stop dates methods --
  Future<void> selectTStopStartDate(BuildContext context, ) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);

      stopStartDateController.text = formattedDate;
      stopStartDate = selectedDate;
      datesSelectedStopStart = true;
      notifyListeners();
    }

  }
  Future<void> selectTStopFinalDate(BuildContext context, ) async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: getDate(),
        firstDate: getDate(),
        lastDate: DateTime(2026)
    );
    if(selectedDate != null){
      final locale = Localizations.localeOf(context).toString();
      final formattedDate = DateFormat.yMd(locale).format(selectedDate);

      stopFinalDateController.text = formattedDate;
      stopFinalDate = selectedDate;
      datesSelectedStopFinal = true;
      notifyListeners();
    }

  }
  // ----------------------



  String? error;

  // -- stop validator methods --
  Validator validateStop(){
    double? latitude = double.tryParse(stopDestinationLatitude.text);
    double? longitude = double.tryParse(stopDestinationLongitude.text);


    if(!datesSelectedStopStart || !datesSelectedStopFinal){
      return Validator(false, "datesNotSelected");
    } if(latitude == null || longitude == null){
      return Validator(false, 'invalidCoordinates');
    }
    TravelStop stop = TravelStop(
      stopStartDate!,
      stopFinalDate!,
      stopDestination.text,
      experiencesList,
      latitude,
      longitude,

    );

    Validator stopValidate = stop.stopValidator(stop);
    if(!stopValidate.success){
      return stopValidate;
    }

    if(isEditingStop == false){
      travelStopList.add(stop);
      print(' lista de experiencias no provider: ${experiencesList}');
    } else{
      travelStopList[stopEditIndex!] = stop;
      print(" editou e adicionou: ${stop.experiencesList}");
      isEditingStop = false;

    }
    notifyListeners();

    return Validator(true, null);
  }
  void clearStopData(){
    error = null;
    stopStartDate = null;
    stopFinalDate = null;
    stopDestinationLongitude.clear();
    stopDestinationLatitude.clear();
    stopDestination.text = '';
    experiencesList = [];
    stopDestination.clear();
    stopEditIndex = null;
  }
  // ----------------------------

  // to set the controllers and variables to receive their values from a stop
  void setStopEdit(TravelStop stop, int index){
    clearStopData();
    isEditingStop = true;
    stopEditIndex = index;
    toggleStopDestinationController(stop.cityName);
    stopDestinationLatitude.text = stop.latitude.toString();
    stopDestinationLongitude.text = stop.longitude.toString();
    stopStartDate = stop.arrival;
    stopFinalDate = stop.departure;
    experiencesList.add(stop.experiencesList[0]);
    print("atual lista dentro de setStopEdit: $experiencesList}");
    notifyListeners();
  }

  //-----------------------------------------------------------------------------

}
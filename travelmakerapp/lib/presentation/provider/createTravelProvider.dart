import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import 'package:travelmakerapp/services/googleAPI.dart';
import '../../entities/response.dart';
import '../../usecase/dates/getDate.dart';
import '../../usecase/sharedPreferences/sharedPreferencesInstance.dart';

class CreateTravelProvider with ChangeNotifier{

  // -- GENERAL METHODS that can be used for travel or stop --

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


  // -----------------------------------------------------------


  // -- get user info methods --

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

  // --------------------------


  int? stopEditIndex;
  int? travelEditIndex;

  // -- TRAVEL variables (used for storage or controlling the state of the provider--

  late DateTime? travelStartDate;
  late DateTime? travelFinalDate;

  late DateTime? stopStartDate;
  late DateTime? stopFinalDate;

  // dates from travel
  bool datesSelectedTravelStart = false;
  bool datesSelectedTravelFinal = false;

  // dates from stop
  bool datesSelectedStopStart = false;
  bool datesSelectedStopFinal = false;

  //stores the persons of this travel
  List<Person> travelPersonsList = [];

  // stores the stops of this travel
  List<TravelStop> travelStopList = [];

  //vehicle chosen
  Vehicles vehicleChosen = Vehicles.notSelected;

  bool isVehicleExpanded = true;



  // ---------------------------------------------------------------------------




  // -- TRAVEL FORM controllers & formKeys --

  // controllers
  final travelTitleController = TextEditingController();
  final travelDescriptionController = TextEditingController();
  final travelDestinationController = TextEditingController();

  final travelStartDateController = TextEditingController();
  final travelFinalDateController = TextEditingController();

  // formKeys
  final GlobalKey<FormFieldState> travelTitleFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDescriptionFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDestinationFormFieldKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> travelStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelFinalDateFormKey = GlobalKey<FormFieldState>();



  bool isEditingStop = false;

  // -------------------------------------------------------------------------------------


  // -- STOP FORM controllers, formKeys & methods --
  final stopDestination = TextEditingController();
  final stopStartDateController = TextEditingController();
  final stopFinalDateController = TextEditingController();
  final stopDestinationLatitude = TextEditingController();
  final stopDestinationLongitude = TextEditingController();

  final GlobalKey<FormFieldState> stopDestinationFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stopStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stopFinalDateFormKey = GlobalKey<FormFieldState>();

  // (sets the travelDestinationController text equals the city that it gets selected on the suggestion)
  void toggleTravelDestinationController(String description){
    travelDestinationController.text = description;
    notifyListeners();
  }
  void toggleStopDestinationController(String description){
    stopDestination.text = description;
    notifyListeners();
  }


  List<ExperiencesList> experiencesList = [];

  void updateExperienceList(ExperiencesList experience){
    if(experiencesList.contains(experience)){
      experiencesList.remove(experience);
    } else{
      experiencesList.add(experience);
    }
    notifyListeners();
  }







  // -------------- TRAVEL METHODS -----------------------------

  //-- vehicles enum methods --
  void toggleVehicleExpanded(bool expanded) {
    isVehicleExpanded = expanded;
    notifyListeners();
  }
  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }
  // --------------------------

  //-- personsList methods --
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

  // -- travel dates methods --
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
      notifyListeners();
    }

  }
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
  // --------------------------

  // -- travel validator methods --
  void createTravel(){
    // throw to Travel and validates by the rules in that file, if validator
    // return (true and null) => Add travel to User and DataBase! Return to homePage!
    // if not, throw an dialog

    if(datesSelectedTravelStart == false || datesSelectedTravelFinal == false){
      error = 'datesNotSelected';

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
        error = validator.message;
      }

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



  // --------------------------------------------------------------------
























  String? error;





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


}
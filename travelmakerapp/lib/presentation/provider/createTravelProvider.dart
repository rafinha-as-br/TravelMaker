import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/experiences.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import '../../entities/response.dart';
import '../../usecase/dates/getDate.dart';
import '../../usecase/sharedPreferences/sharedPreferencesInstance.dart';

class CreateTravelProvider with ChangeNotifier{

  final sharedPreferences = SharedPreferencesInstance().preferences;

  bool userAdded = false;

  late DateTime? travelStartDate;
  late DateTime? travelFinalDate;

  late DateTime? stopStartDate;
  late DateTime? stopFinalDate;

  // dates from travel
  bool datesSelected1 = false;
  bool datesSelected2 = false;

  // dates from stop
  bool datesSelected3 = false;
  bool datesSelected4 = false;

  bool isDatesSelected(){
    if(datesSelected1 == true && datesSelected2 == true){
      return true;
    } else{
      return false;
    }
  }
  bool isDatesSelected2(){
    if(datesSelected3 == true && datesSelected4 == true){
      return true;
    } else{
      return false;
    }
  }

  // -- TRAVEL FORM controllers & formKeys --

  // controllers
  final travelTitleController = TextEditingController();
  final travelDescriptionController = TextEditingController();
  final travelDestinationController = TextEditingController();

  final travelStartDateController = TextEditingController();
  final travelFinalDateController = TextEditingController();

  final stopStartDateController = TextEditingController();
  final stopFinalDateController = TextEditingController();

  final stopDestinationLatitude = TextEditingController();
  final stopDestinationLongitude = TextEditingController();

  // formKeys
  final GlobalKey<FormFieldState> travelTitleFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDescriptionFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDestinationFormFieldKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> travelStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelFinalDateFormKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> stopStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stopFinalDateFormKey = GlobalKey<FormFieldState>();




  // ---


  // sets the travelDestinationController text equals the city that it gets selected on the suggestion
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







  // controls the stop destination textField on the stopForm
  final stopDestination = TextEditingController();
  final GlobalKey<FormFieldState> stopDestinationFormKey = GlobalKey<FormFieldState>();



  //vehicle chosen
  Vehicles vehicleChosen = Vehicles.notSelected;

  bool isVehicleExpanded = true;

  //travel person list
  List<Person> travelPersonsList = [];

  //travel stops list
  List<TravelStop> travelStopList = [];

  Future<String> getUserName() async {
    String? name = sharedPreferences.getString('userName');
    return name ?? '';
  }

  Future<int> getUserAge() async {
    int? age = sharedPreferences.getInt('userAge');
    return age ?? 0;
  }


  //---- vehicles functions -----
  void toggleVehicleExpanded(bool expanded) {
    isVehicleExpanded = expanded;
    notifyListeners();
  }
  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }



  //---- personsList functions ----
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
  // ----------------------------------


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
      datesSelected3 = true;
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
      datesSelected4 = true;
      notifyListeners();
    }

  }


  int daysSpent(DateTime startDate, DateTime finalDate){
    int timeSpent;
    timeSpent = finalDate.difference(startDate).inDays;
    return timeSpent;

  }

  String? error;

  // throw to Travel and validates by the rules in that file, if validator
  // return (true and null) => Add travel to User and DataBase! Return to homePage!
  // if not, throw an dialog
  void createTravel(){

    if(datesSelected1 == false || datesSelected2 == false){
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
      } else{
        error = null;
        travelTitleController.clear();
        travelDescriptionController.clear();
        travelStartDate = null;
        travelFinalDate = null;
        vehicleChosen = Vehicles.notSelected;
        travelStopList.clear();
        travelPersonsList.clear();
      }

    }
    notifyListeners();
  }


  void addStop(){
    double latitude = double.parse(stopDestinationLatitude.text);
    double longitude = double.parse(stopDestinationLongitude.text);


    if(datesSelected3 == false || datesSelected4 == false){
      error = 'datesNotSelected';
    } else{
      TravelStop stop = TravelStop(
        stopStartDate!,
        stopFinalDate!,
        stopDestination.text,
        experiencesList,
        double.parse(stopDestinationLatitude.text),
        double.parse(stopDestinationLongitude.text),

      );

      Validator stopValidate = stop.stopValidator(stop);
      if(!stopValidate.success){
        error = stopValidate.message;
      } else{

        error = null;
        stopStartDate = null;
        stopFinalDate = null;
        experiencesList.clear();
        stopDestination.clear();

      }

    }

    notifyListeners();
  }



}
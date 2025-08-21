import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/entities/experiences.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import '../../usecase/dates/getDate.dart';
import '../../usecase/sharedPreferences/sharedPreferencesInstance.dart';

class CreateTravelProvider with ChangeNotifier{

  final sharedPreferences = SharedPreferencesInstance().preferences;

  bool userAdded = false;

  late DateTime travelStartDate;
  late DateTime travelFinalDate;

  late DateTime stopStartDate;
  late DateTime stopFinalDate;

  bool datesSelected1 = false;
  bool datesSelected2 = false;

  bool isDatesSelected(){
    if(datesSelected1 == true && datesSelected2 == true){
      return true;
    } else{
      return false;
    }
  }

  // -- TRAVEL FORM controllers & formKeys --

  // controllers
  final travelTitle = TextEditingController();
  final travelDescription = TextEditingController();
  final travelDestination = TextEditingController();

  final travelStartDateController = TextEditingController();
  final travelFinalDateController = TextEditingController();

  final stopStartDateController = TextEditingController();
  final stopFinalDateController = TextEditingController();


  // formKeys
  final GlobalKey<FormFieldState> travelTitleFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDescriptionFormFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDestinationFormFieldKey = GlobalKey<FormFieldState>();

  // ---


  // sets the travelDestinationController text equals the city that it gets selected on the suggestion
  void toggleTravelDestinationController(String description){
    travelDestination.text = description;
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






  final GlobalKey<FormFieldState> travelStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelFinalDateFormKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> stopStartDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stopFinalDateFormKey = GlobalKey<FormFieldState>();

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

  Future<void> addUserToPersonList() async{
    final name = await getUserName();
    final age = await getUserAge();
    updatePersonsList(Person(name: name, age: age));
    notifyListeners();
  }


  void toggleVehicleExpanded(bool expanded) {
    isVehicleExpanded = expanded;
    notifyListeners();
  }

  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }

  //update persons function
  void updatePersonsList(Person person, {int? index}) {
    if (index != null) {
      travelPersonsList[index] = person;
    } else {
      travelPersonsList.add(person);
    }
    notifyListeners();
  }


  void removePerson(index){
    travelPersonsList.removeAt(index);
    notifyListeners();
  }


  Future<void> selectTravelStartDate(BuildContext context, ) async{
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
      datesSelected1 = true;
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
      datesSelected2 = true;
      notifyListeners();
    }

  }


  int daysSpent(DateTime startDate, DateTime finalDate){
    int timeSpent;
    timeSpent = finalDate.difference(startDate).inDays;
    return timeSpent;

  }

}
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import '../../entities/person.dart';
import '../../view/presentation/helpers/pickImageFromGallery.dart';


// controls an instance of person (edit or create)
class PersonProvider with ChangeNotifier{

  bool editMode = false;
  bool isVehicleExpanded = false;

  int? editIndex;


  Vehicles vehicleChosen = Vehicles.notSelected;

  final personNameController = TextEditingController();
  final personAgeController = TextEditingController();

  String? profilePicturePath;


  // set the controllers for the same as the person that were selected
  void setPersonToEdit(Person person, int index) {
    personNameController.text = person.name;
    personAgeController.text = person.age.toString();
    vehicleChosen = person.preferredVehicle;
    profilePicturePath = person.profilePicture;
    editIndex = index;

    notifyListeners();
  }

  void toggleVehicleExpanded(bool value){
    isVehicleExpanded = value;
    notifyListeners();
  }

  void selectVehicle(Vehicles vehicle){
    vehicleChosen = vehicle;
    notifyListeners();
  }


  void resetPersonControllers(){
    personNameController.text = '';
    personAgeController.text = '';
    vehicleChosen = Vehicles.notSelected;
    profilePicturePath = null;
    editIndex = null;

    notifyListeners();
  }

  void toogleEditPersonMode(bool status){
    editMode = status;
    notifyListeners();
  }

  Future<void> selectProfilePicture() async {

    final selectedImage = await pickImageFromGallery();
    if (selectedImage != null) {
      profilePicturePath = selectedImage.path;
      notifyListeners();
    }
  }

  Validator validatePerson() {
    Person person = Person(
        name: personNameController.text,
        age: int.tryParse(personAgeController.text)?? 0,
        preferredVehicle: vehicleChosen,
        profilePicture: profilePicturePath
    );

    Validator personValidate = person.validatePerson(person);
    return personValidate;

  }






}
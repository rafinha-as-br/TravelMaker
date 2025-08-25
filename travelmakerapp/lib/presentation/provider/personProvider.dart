import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/response.dart';
import '../../entities/person.dart';
import '../../usecase/pickImageFromGallery.dart';


// controls an instance of person (edit or create)
class PersonProvider with ChangeNotifier{

  bool editMode = false;
  int? editIndex;

  final personNameController = TextEditingController();
  final personAgeController = TextEditingController();

  String? profilePicturePath;


  // set the controllers for the same as the person that were selected
  void setPersonToEdit(Person person, int index) {
    personNameController.text = person.name;
    personAgeController.text = person.age.toString();
    profilePicturePath = person.profilePicture;
    editIndex = index;

    notifyListeners();
  }

  void resetPersonControllers(){
    personNameController.text = '';
    personAgeController.text = '';
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
        profilePicture: profilePicturePath
    );

    Validator personValidate = person.validatePerson(person);
    return personValidate;

  }






}
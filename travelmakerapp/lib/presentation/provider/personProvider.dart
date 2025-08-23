import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/response.dart';
import '../../entities/person.dart';
import '../../usecase/pickImageFromGallery.dart';


// controls an instance of person (edit or create)
class PersonProvider with ChangeNotifier{

  Person person = Person(name: '', age: 0);
  bool editMode = false;
  int? editIndex;

  final personNameController = TextEditingController();
  final personAgeController = TextEditingController();

  Validator validatePerson(){
    person.name = personNameController.text;
    person.age = int.parse(personAgeController.text);

   final validatePerson = person.validatePerson(person);
   return validatePerson;
  }

  // updates the instance of person in this provider to the person that the user wants do edit
  void setPersonToEdit(Person person, int index) {
    this.person = person;
    editIndex = index;
    notifyListeners();
  }

  void resetPersonProvider(){
    person.name = '';
    person.age = 0;
    person.profilePicture = null;
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
      person.profilePicture = selectedImage.path;
      notifyListeners();
    }
  }





}
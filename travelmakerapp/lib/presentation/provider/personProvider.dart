import 'package:flutter/material.dart';
import '../../entities/person.dart';
import '../../usecase/pickImageFromGallery.dart';


// controls an instance of person (edit or create)
class PersonProvider with ChangeNotifier{

  Person person = Person(name: '', age: 0);

  bool editMode = false;

  int? editIndex;

  void setPersonToEdit(Person person, int index) {
    this.person = person;
    this.editIndex = index;
    notifyListeners();
  }

  void resetPersonProvider(){
    person.name = '';
    person.age = 0;
    person.profilePicture = null;
    editIndex = null;

    notifyListeners();
  }

  void editPersonMode(bool status){
    editMode = status;
    notifyListeners();
  }

  void setPersonData(String name, int age){
    person.name = name;
    person.age = age;

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
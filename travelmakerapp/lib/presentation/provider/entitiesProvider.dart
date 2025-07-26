import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travelmakerapp/database/database.dart';
import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/person.dart';

import '../../entities/user.dart';

class EntitiesProvider extends ChangeNotifier{

  // database open Methods



  // List of Persons
  List<Person> personsList = [];

  // List of travels
  List<Travel> travelsList = [];

  // functions

  //

  // creates and person and adds to the DataBase
  Future<void> createPerson(String name, int age) async{
    final database = await getDatabase();
    Person person = Person(name: name, age: age);
    await database.insert('person', PersonTable.toMap(person));
    personsList.add(person);
    notifyListeners();
  }



}

import 'package:sqflite/sqflite.dart';
import 'package:travelmakerapp/usecase/repositories/repository_person.dart';

import '../../entities/person.dart';

class PersonRepositoryImpl implements PersonRepository{
  final Database db;

  PersonRepositoryImpl(this.db);


  @override
  Future<int> deletePerson(int id) async {
    return await db.delete(
      'person',
      where: 'personID = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> insertPerson(Map<String, dynamic> person) async {
    try{
      int id;
      id = await db.insert(
        'person',
        person,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return id;
    } catch (e){
      print(e);
      return -1;
    }

  }

  @override
  Future<int> updatePerson(int id, Map<String, dynamic> person) async{
    return await db.update(
      'person',
      person,
      where: 'personID = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getPersonsByTravelId(int travelID) async {
    try {
      final List<Map<String, dynamic>> result = await db.query(
        'person',
        where: 'travel_id = ?',
        whereArgs: [travelID],
      );
      return result;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>?> getPersonById(int personID) async {
    try {
      final List<Map<String, dynamic>> result = await db.query(
        'person',
        where: 'personID = ?',
        whereArgs: [personID],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return result.first;
      } else {
        return null;
      }
    } catch (e) {
      print("Erro ao buscar pessoa: $e");
      return null;
    }
  }


  
  
}
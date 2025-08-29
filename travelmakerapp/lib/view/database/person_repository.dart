import 'package:travelmakerapp/usecase/repositories/person_repository_database.dart';
import 'database.dart';

class PersonRepositoryImpl implements PersonRepositoryDataBase {
  @override
  Future<int> insertPerson(Map<String, dynamic> person) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('person', person);
  }

  @override
  Future<int> updatePerson(int id, Map<String, dynamic> person) async {
    final db = await AppDatabase.instance.database;
    return await db.update(
      'person',
      person,
      where: 'personID = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deletePerson(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(
      'person',
      where: 'personID = ?',
      whereArgs: [id],
    );
  }
}

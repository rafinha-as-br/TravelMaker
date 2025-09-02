import 'package:sqflite/sqflite.dart';
import 'package:travelmakerapp/usecase/repositories/travel_repository_database.dart';
import 'database.dart';

/*
class TravelRepositoryImpl implements TravelRepositoryDataBase {
  @override
  Future<int> insertTravel(Map<String, dynamic> travel) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('travel', travel);
  }

  @override
  Future<int> updateTravel(int id, Map<String, dynamic> travel) async {
    final db = await AppDatabase.instance.database;
    return await db.update(
      'travel',
      travel,
      where: 'travelID = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteTravel(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(
      'travel',
      where: 'travelID = ?',
      whereArgs: [id],
    );
  }
}

 */

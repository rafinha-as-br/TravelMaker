import 'package:sqflite/sqflite.dart';
import 'package:travelmakerapp/usecase/repositories/travel_stop_repository_database.dart';
import 'database.dart';

class TravelStopRepositoryImpl implements TravelStopRepositoryDataBase {
  @override
  Future<int> insertTravelStop(Map<String, dynamic> stop) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('travel_stop', stop);
  }

  @override
  Future<int> updateTravelStop(int id, Map<String, dynamic> stop) async {
    final db = await AppDatabase.instance.database;
    return await db.update(
      'travel_stop',
      stop,
      where: 'stop_id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteTravelStop(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(
      'travel_stop',
      where: 'stop_id = ?',
      whereArgs: [id],
    );
  }
}

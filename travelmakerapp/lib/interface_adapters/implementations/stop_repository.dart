import 'package:sqflite/sqflite.dart';

import '../../usecase/repositories/stop_repository.dart';

class StopRepositoryImpl implements StopRepository {
  final Database db;

  StopRepositoryImpl(this.db);

  @override
  Future<int> insertTravelStop(Map<String, dynamic> stop) async {
    return await db.insert('travel_stop', stop);
  }

  @override
  Future<int> updateTravelStop(int id, Map<String, dynamic> stop) async {
    return await db.update(
      'travel_stop',
      stop,
      where: 'stop_id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteTravelStop(int id) async {
    return await db.delete(
      'travel_stop',
      where: 'stop_id = ?',
      whereArgs: [id],
    );
  }
}

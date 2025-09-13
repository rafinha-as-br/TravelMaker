import 'package:sqflite/sqflite.dart';

import '../../usecase/repositories/stop_repository.dart';

class StopRepositoryImpl implements StopRepository {
  final Database db;

  StopRepositoryImpl(this.db);

  @override
  Future<int> insertTravelStop(Map<String, dynamic> stop) async {
    try{
      int stopInsert = await db.insert('travel_stop', stop);
      return stopInsert;
    } catch (e){
      return -1;
    }
  }

  @override
  Future<int> updateTravelStop(int id, Map<String, dynamic> stop) async {
    try{
      int stopUpdate = await db.update(
        'travel_stop',
        stop,
        where: 'stop_id = ?',
        whereArgs: [id],
      );
      return stopUpdate;
    } catch(e){
      return -1;
    }

  }

  @override
  Future<int> deleteTravelStop(int id) async {
    try{
      int deleteTravel = await db.delete(
        'travel_stop',
        where: 'stop_id = ?',
        whereArgs: [id],
      );
      return deleteTravel;
    }catch (e){
      return -1;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getStopsFromTravelID(int travelID) async {
    try {
      final List<Map<String, dynamic>> stops = await db.query(
        'travel_stop',
        where: 'travel_id = ?',
        whereArgs: [travelID],
      );
      return stops;
    } catch (e) {
      return [];
    }
  }





}


import 'package:sqflite/sqflite.dart';
import 'package:travelmakerapp/usecase/repositories/travel_repository.dart';

class TravelRepositoryImpl implements TravelRepository{
  final Database db;

  TravelRepositoryImpl(this.db);



  @override
  Future<int> insertTravel(Map<String, dynamic> travel) async {
    try{
      int id = await db.insert('travel', travel);
      return id;
    } catch(e){
      print(e);
      return -1;
    }

  }

  @override
  Future<int> deleteTravel(int id) async {
    try{
      int delete = await db.delete(
        'travel',
        where: 'travelID = ?',
        whereArgs: [id],
      );
      return delete;
    } catch (e){
      return -1;
    }
  }


  @override
  Future<int> updateTravel(int id, Map<String, dynamic> travel) async {
    try{
      int update = await db.update(
        'travel',
        travel,
        where: 'travelID = ?',
        whereArgs: [id],
      );
      return update;
    }catch (e){
      return -1;
    }
  }


}
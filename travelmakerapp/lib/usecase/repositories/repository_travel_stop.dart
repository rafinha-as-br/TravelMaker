/// contract repository for TravelStop storage on database
abstract class StopRepository {

  /// to insert a travelStop on database
  Future<int> insertTravelStop(Map<String, dynamic> stop);

  /// to update a TravelStop on databse by id
  Future<int> updateTravelStop(int id, Map<String, dynamic> stop);

  /// to delete a travelStop by id
  Future<int> deleteTravelStop(int id);

  /// query to get a travelStop list map by travel ID
  Future<List<Map<String, dynamic>>> getStopsFromTravelID(int travelID);
}
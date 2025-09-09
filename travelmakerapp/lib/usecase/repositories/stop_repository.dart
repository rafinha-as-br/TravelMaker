abstract class StopRepository {
  Future<int> insertTravelStop(Map<String, dynamic> stop);
  Future<int> updateTravelStop(int id, Map<String, dynamic> stop);
  Future<int> deleteTravelStop(int id);
  Future<List<Map<String, dynamic>>> getStopsFromTravelID(int travelID);
}
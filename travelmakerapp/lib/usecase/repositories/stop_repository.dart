abstract class StopRepository {
  Future<int> insertTravelStop(Map<String, dynamic> stop);
  Future<int> updateTravelStop(int id, Map<String, dynamic> stop);
  Future<int> deleteTravelStop(int id);
}
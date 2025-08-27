abstract class TravelRepositoryDataBase {
  Future<int> insertTravel(Map<String, dynamic> travel);
  Future<int> updateTravel(int id, Map<String, dynamic> travel);
  Future<int> deleteTravel(int id);
}

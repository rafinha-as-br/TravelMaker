
/// contract repository for travel storage on database
abstract class TravelRepository {

  /// to insert a travel on database
  Future<int> insertTravel(Map<String, dynamic> travel);

  /// to update a travel by id on database
  Future<int> updateTravel(int id, Map<String, dynamic> travel);

  /// to delete a travel by id on database
  Future<int> deleteTravel(int id);

  /// to get a list of travels by userID
  Future<List<Map<String, dynamic>>> getTravelsByUserId(int userId);
}







/// contract repository for person storage
abstract class PersonRepository {

  /// to insert a person into the database
  Future<int> insertPerson(Map<String, dynamic> person);
  Future<int> updatePerson(int id, Map<String, dynamic> person);
  Future<int> deletePerson(int id);
  Future<List<Map<String, dynamic>>> getPersonsByTravelId(int travelId);

}


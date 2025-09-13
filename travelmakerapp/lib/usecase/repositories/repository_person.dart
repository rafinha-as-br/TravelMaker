
/// contract repository for person storage
abstract class PersonRepository {

  /// to insert a person into the database
  Future<int> insertPerson(Map<String, dynamic> person);

  /// to update a person into the database by id
  Future<int> updatePerson(int id, Map<String, dynamic> person);

  /// to delete a person from the database by id
  Future<int> deletePerson(int id);

  /// to get a list of persons by travelID
  Future<List<Map<String, dynamic>>> getPersonsByTravelId(int travelId);

  ///to get a person by id
  Future<Map<String, dynamic>?>  getPersonById(int personID);


}


abstract class PersonRepositoryDataBase {
  Future<int> insertPerson(Map<String, dynamic> person);
  Future<int> updatePerson(int id, Map<String, dynamic> person);
  Future<int> deletePerson(int id);
}

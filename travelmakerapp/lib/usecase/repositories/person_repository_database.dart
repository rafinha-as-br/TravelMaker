import '../../entities/person.dart';

abstract class PersonRepository {
  Future<int> insertPerson(Map<String, dynamic> person);
  Future<int> updatePerson(int id, Map<String, dynamic> person);
  Future<int> deletePerson(int id);
  Future<List<Person>> getPersonsByTravelId(int travelId);

}

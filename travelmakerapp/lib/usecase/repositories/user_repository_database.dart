abstract class UserRepositoryDataBase {
  Future<int> insertUser(Map<String, dynamic> user);
  Future<int> updateUser(int id, Map<String, dynamic> user);
  Future<int> deleteUser(int id);
}

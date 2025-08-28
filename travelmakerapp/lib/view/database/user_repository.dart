import 'package:travelmakerapp/usecase/repositories/user_repository_database.dart';
import 'database.dart';

class UserRepositoryImpl implements UserRepositoryDataBase {
  @override
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await AppDatabase.instance.database;
    return await db.insert('user', user);
  }

  @override
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await AppDatabase.instance.database;
    return await db.update(
      'user',
      user,
      where: 'userID = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteUser(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(
      'user',
      where: 'userID = ?',
      whereArgs: [id],
    );
  }
}

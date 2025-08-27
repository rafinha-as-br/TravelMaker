import 'package:sqflite/sqflite.dart';
import 'database.dart';

class DatabaseRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Insert data into a table
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await _dbHelper.database;
    return await db.insert(table, data);
  }

  /// Get all rows from a table
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await _dbHelper.database;
    return await db.query(table);
  }

  /// Get a row by id
  Future<Map<String, dynamic>?> getById(String table, String idColumn, int id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      table,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  /// Update a row by id
  Future<int> update(String table, String idColumn, int id, Map<String, dynamic> data) async {
    final db = await _dbHelper.database;
    return await db.update(
      table,
      data,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }

  /// Delete a row by id
  Future<int> delete(String table, String idColumn, int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      table,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }
}

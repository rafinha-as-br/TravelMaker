import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('travel_maker_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Table: user
    await db.execute('''
      CREATE TABLE user(
        userID INTEGER PRIMARY KEY AUTOINCREMENT,
        user_name TEXT NOT NULL, 
        user_age INTEGER NOT NULL,
        user_profile_picture_path TEXT NOT NULL
      )
    ''');

    // Table: travel
    await db.execute('''
      CREATE TABLE travel (
        travelID INTEGER PRIMARY KEY AUTOINCREMENT,
        userID INTEGER NOT NULL,
        travel_name TEXT NOT NULL,
        travel_description TEXT NOT NULL,
        travel_destination TEXT NOT NULL,
        destination_lat REAL NOT NULL,
        destination_long REAL NOT NULL,
        departure DATE NOT NULL, 
        arrival DATE NOT NULL, 
        selected_vehicle INTEGER NOT NULL
      )
    ''');

    // Table: travel_stop
    await db.execute('''
      CREATE TABLE travel_stop(
        stop_id INTEGER PRIMARY KEY AUTOINCREMENT,
        travel_id INTEGER NOT NULL,
        stop_destination TEXT NOT NULL,
        destination_lat REAL NOT NULL,
        destination_long REAL NOT NULL,
        stop_descr TEXT NOT NULL,
        departure DATE NOT NULL,
        arrival DATE NOT NULL,
        stop_picture_path TEXT NOT NULL
      )
    ''');

    // Table: person
    await db.execute('''
      CREATE TABLE person(
        personID INTEGER PRIMARY KEY AUTOINCREMENT,
        travel_id INTEGER NOT NULL,
        person_name TEXT NOT NULL, 
        person_age INTEGER NOT NULL, 
        preferred_vehicle INTEGER NOT NULL,
        profile_picture_path TEXT NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

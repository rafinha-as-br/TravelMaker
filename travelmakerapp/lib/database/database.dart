import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'travelmaker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        active INTEGER NOT NULL,
        dark_theme INTEGER NOT NULL,
        language TEXT,
        locale TEXT,
        profile_picture_path TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE persons (
        person_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        profile_picture TEXT,
        preferred_vehicle INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE travels (
        travel_id INTEGER PRIMARY KEY AUTOINCREMENT,
        travel_name TEXT NOT NULL,
        description TEXT,
        city TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        passed INTEGER NOT NULL,
        departure TEXT NOT NULL,
        arrival TEXT NOT NULL,
        desired_vehicle INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE travel_stops (
        stop_id INTEGER PRIMARY KEY AUTOINCREMENT,
        travel_id INTEGER NOT NULL,
        city TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        passed INTEGER NOT NULL,
        arrival TEXT,
        departure TEXT,
        stop_picture TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE travel_members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        travel_id INTEGER NOT NULL,
        person_id INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE travel_experiences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        travel_id INTEGER NOT NULL,
        experience_id INTEGER NOT NULL
      )
    ''');
  }
}

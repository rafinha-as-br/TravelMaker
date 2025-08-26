import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:travelmakerapp/entities/person.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'travelMakerApp.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(PersonTable.createTable);
      db.execute(TravelTable.createTable);
      db.execute(TravelStopTable.createTable);
      db.execute(ExperienceTable.createTable);
      db.execute(UserTravelTable.createTable);
    },
    version: 1,
  );
}

class UserTravelTable {
  static const String createTable = ''' 
  CREATE TABLE $tableName (
    $userID INTEGER NOT NULL,
    $travelID INTEGER NOT NULL,
    PRIMARY KEY ($userID, $travelID)
  );
  ''';

  static const String tableName = 'UserTravel';
  static const String userID = 'userID';
  static const String travelID = 'travelID';
}

class PersonTable {
  static const String createTable = '''
  CREATE TABLE $tableName (
    $personID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $name TEXT NOT NULL,
    $age INTEGER NOT NULL,
    $profilePicturePath TEXT,
    $travelID INTEGER NOT NULL,
    $preferredVehicle TEXT NOT NULL
  );
  ''';

  static const String tableName = 'Person';
  static const String personID = 'id';
  static const String name = 'name';
  static const String age = 'age';
  static const String profilePicturePath = 'profilePicturePath';
  static const String travelID = 'travelID';
  static const String preferredVehicle = 'preferredVehicle';

  static Map<String, dynamic> toMap(Person person) {
    final map = <String, dynamic>{};
    map[PersonTable.personID] = person.personId;
    map[PersonTable.name] = person.name;
    map[PersonTable.age] = person.age;
    map[PersonTable.profilePicturePath] = person.profilePicture;
    return map;
  }
}

class TravelTable {
  static const String createTable = '''
  CREATE TABLE $tableName (
    $travelID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $travelName TEXT NOT NULL,
    $travelDescription TEXT,
    $departure TEXT NOT NULL,
    $arrival TEXT NOT NULL,
    $desiredVehicle TEXT NOT NULL, 
    $destination TEXT NOT NULL,
    $latitude REAL NOT NULL,
    $longitude REAL NOT NULL,
    $status INTEGER NOT NULL
  );
  ''';

  static const String tableName = 'Travel';
  static const String travelID = 'travelID';
  static const String travelName = 'travelName';
  static const String travelDescription = 'description';
  static const String departure = 'departure';
  static const String arrival = 'arrival';
  static const String desiredVehicle = 'desiredVehicle';
  static const String destination = 'destination';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String status = 'status';
}

class TravelStopTable {
  static const String createTable = '''
  CREATE TABLE $tableName (
    $stopID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $travelID INTEGER NOT NULL,
    $arrival TEXT NOT NULL,
    $departure TEXT NOT NULL,
    $timeSpent INTEGER NOT NULL,
    $description TEXT NOT NULL,
    $cityName TEXT NOT NULL,
    $latitude REAL NOT NULL,
    $longitude REAL NOT NULL,
    $stopPicturePath TEXT,
    $status INTEGER NOT NULL
  );
  ''';

  static const String tableName = 'TravelStop';
  static const String stopID = 'stopID';
  static const String travelID = 'travelID';
  static const String arrival = 'arrival';
  static const String departure = 'departure';
  static const String timeSpent = 'timeSpent';
  static const String description = 'description';
  static const String cityName = 'cityName';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String stopPicturePath = 'stopPicturePath';
  static const String status = 'status';
}

class ExperienceTable {
  static const String createTable = '''
  CREATE TABLE $tableName (
    $experienceID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $travelID INTEGER NOT NULL,
    $type TEXT NOT NULL
  );
  ''';

  static const String tableName = 'Experience';
  static const String experienceID = 'experienceID';
  static const String travelID = 'travelID';
  static const String type = 'type'; // para armazenar o enum
}

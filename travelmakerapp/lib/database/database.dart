import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:travelmakerapp/entities/person.dart';

Future<Database> getDatabase() async {
  final path = join(
      await getDatabasesPath(),
      'travelMakerApp.db'
  );

  return openDatabase(
    path,
    onCreate: (db, version){
      db.execute(PersonTable.createTable);
      db.execute(PersonOnTravelsTable.createTable);
      db.execute(TravelTable.createTable);
      db.execute(TravelStopTable.createTable);
      db.execute(ExperienceTable.createTable);
      db.execute(ExperiencesListTable.createTable);

    },
    version: 1,

  );


}


class PersonTable{
  static const String createTable = '''
  CREATE TABLE $tableName(
  $personID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $name TEXT NOT NULL,
  $age INTEGER NOT NULL,
  $profilePicturePath TEXT
  );
  ''';

  static const String tableName = 'Person';
  static const String personID = 'id';
  static const String name = 'name';
  static const String age = 'age';
  static const String profilePicturePath = 'profilePicturePath';

  static Map<String, dynamic> toMap(Person person){
    final map = <String, dynamic>{};

    map[PersonTable.personID] = person.personId;
    map[PersonTable.name] = person.name;
    map[PersonTable.age] = person.age;
    map[PersonTable.profilePicturePath] = person.profilePicture;

    return map;
  }


}

class PersonOnTravelsTable{
  static const String createTable = '''
  CREATE TABLE $tableName(
  $personID INTEGER NOT NULL,
  $travelID INTEGER NOT NULL
  );
  
  ''';
  static const String tableName = 'PersonOnTravels';
  static const String personID = 'personID';
  static const String travelID = 'travelID';
}

class TravelTable{
  static const String createTable = '''
  CREATE TABLE $tableName(
  $travelID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $travelName TEXT NOT NULL,
  $departure DATE NOT NULL,
  $arrival DATE NOT NULL,
  $desiredVehicle TEXT NOT NULL 
  ):
  ''';


  static const String tableName = 'Travel';
  static const String travelID = 'travelID';
  static const String travelName = 'travelName';
  static const String departure = 'departure';
  static const String arrival = 'arrival';
  static const String desiredVehicle = 'desiredVehicle';

}

class TravelStopTable{
  static const String createTable = '''
  CREATE TABLE $tableName(
  $stopID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $arrival DATE NOT NULL,
  $departure DATE NOT NULL,
  $timeSpent INTEGER NOT NULL,
  $description TEXT NOT NULL,
  $cityName TEXT NOT NULL,
  $latitude INTEGER NOT NULL,
  $longitude INTEGER NOT NULL,
  $stopPicturePath TEXT,
  $status TEXT NOT NULL
  
  );
  
  
  ''';

  static const String tableName = 'TravelStop';
  static const String stopID = 'stopID';
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

class ExperiencesListTable{
  static const String createTable = '''
  CREATE TABLE $tableName(
  $stopID INTEGER NOT NULL,
  $experienceID INTEGER NOT NULL
  );
  ''';
  static const tableName = 'ExperiencesList';
  static const String stopID = 'stopID';
  static const String experienceID = 'experienceID';


}

class ExperienceTable {
  static const String createTable = '''
  CREATE TABLE $tableName(
  $experienceID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  );
  ''';

  static const tableName = 'Experience';
  static const experienceID = 'experienceID';
}
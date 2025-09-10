
import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/usecase/repositories/person_repository_database.dart';
import 'package:travelmakerapp/usecase/repositories/stop_repository.dart';
import 'package:travelmakerapp/usecase/repositories/travel_repository.dart';
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';

import '../entities/validator.dart';

Future<(Validator, List<Travel>)> getTravelsUseCase(
    UserRepository userRepo,
    TravelRepository travelRepo,
    StopRepository stopRepo,
    PersonRepository personRepo
    ) async{
  List<Travel> travelsList = [];

  try{
    // get the userID
    final user = await userRepo.checkExistentUserDataBase();

    int? userdId = user.$2?.userID;

    //get all the travels by user ID
    final travels = await travelRepo.getTravelsByUserId(userdId!);

    for (final storedTravel in travels){

      //transforms from map to entity
      Travel travel = Travel.fromMap(storedTravel);
      print("Passed inside get_travels  ****************");

      // add the stops to the travel
      final stops = await stopRepo.getStopsFromTravelID(travel.travelID!);
      for(final storedStop in stops){
        TravelStop stop = TravelStop.fromMap(storedStop);
        travel.travelStopList.add(stop);
      }

      // add the persons to the travel
      final persons = await personRepo.getPersonsByTravelId(travel.travelID!);
      for(final storedPerson in persons){
        Person person = Person.fromMap(storedPerson);
        travel.membersList.add(person);
      }

      //add into the list
      travelsList.add(travel);
    }

  } catch (e){
    return (Validator(false, 'error get_travels: $e'), travelsList);
  }

  print("Passed inside get_travels");
  return (Validator(true, null), travelsList);
}
import '../entities/travel.dart';
import '../entities/validator.dart';
import 'repositories/repository_person.dart';
import 'repositories/repository_travel.dart';
import 'repositories/repository_travel_stop.dart';
import 'repositories/repository_user.dart';

/// This function is responsible to create a travel
/// joining all the needed data and adding to each responsible repository
Future<Validator> createTravelUseCase(
    Travel travel, 
    TravelRepository travelRepo, 
    UserRepository userRepo,
    StopRepository stopRepo,
    PersonRepository personRepo
    ) async{

  //getting the user ID
  final user = await userRepo.checkExistentUserDataBase();
  if(!user.$1.success || user.$2 == null ){
    return user.$1;
  }


  // validate the travel
  final travelValidate = travel.validateTravel(travel);
  if(!travelValidate.success){
    return travelValidate;
  }

  // add travel to database
  final userID = user.$2?.userID;
  if(userID == null){
    return Validator(false, 'Error: userID is null');
  }
  final travelID = await travelRepo.insertTravel(travel.toMap(userID));
  if(travelID == -1){
    return Validator(false, 'Error on adding the travel to dataBase!');
  }

  // add stops
  for(var i=0; i<travel.travelStopList.length; i++){

    final stopID = await stopRepo.insertTravelStop(
        travel.travelStopList[i].toMap(travelID)
    );
    if(stopID == -1){
      return Validator(false, 'error on adding stop to the dataBase');
    }

  }

  //add persons
  for(var i=0; i<travel.membersList.length; i++){
    final addPerson = await personRepo.insertPerson(
        travel.membersList[i].toMap(travelID)
    );
    if(addPerson == -1){
      return Validator(false, 'error on adding a person into the database');
    }

  }


  return Validator(true, null);
}
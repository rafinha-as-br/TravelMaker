import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/person_repository_database.dart';
import 'package:travelmakerapp/usecase/repositories/stop_repository.dart';
import 'package:travelmakerapp/usecase/repositories/travel_repository.dart';
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';

// create travel
// then add stop

// a function that receives a travel

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
  Validator travelValidate = travel.validateTravel(travel);
  if(!travelValidate.success){
    return travelValidate;
  }

  // add travel to database
  int? userID = user.$2?.userID;
  if(userID == null){
    return Validator(false, 'Error: userID is null');
  }
  int travelID = await travelRepo.insertTravel(travel.toMap(userID));
  if(travelID == -1){
    return Validator(false, 'Error on adding the travel to dataBase!');
  }

  // add stops
  for(int i=0; i<travel.travelStopList.length; i++){
    print("travel ID: ${travelID}");
    
    int stopID = await stopRepo.insertTravelStop(travel.travelStopList[i].toMap(travelID));
    if(stopID == -1){
      return Validator(false, 'error on adding stop to the dataBase');
    }

  }

  //add persons
  for(int i=0; i<travel.membersList.length; i++){
    int addPerson = await personRepo.insertPerson(travel.membersList[i].toMap());
    if(addPerson == -1){
      return Validator(false, 'error on adding a person into the database');
    }

  }


  return Validator(true, null);
}
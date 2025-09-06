import 'package:travelmakerapp/entities/Travel.dart';
import 'package:travelmakerapp/entities/validator.dart';
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
    StopRepository stopRepo
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
  int travelID = await travelRepo.insertTravel(travel.toMap(user.$2!));
  if(travelID == -1){
    return Validator(false, 'Error on adding the travel to dataBase!');
  }

  // add stops
  for(int i=0; i<travel.travelStopList.length; i++){
    int stopID = await stopRepo.insertTravelStop(travel.travelStopList[i].toMap(travel));
    if(stopID == -1){
      return Validator(false, 'error on adding stop to the dataBase');
    }

  }


  return Validator(true, null);
}
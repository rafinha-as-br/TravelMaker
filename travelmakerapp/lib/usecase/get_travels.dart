
import '../entities/Travel.dart';
import '../entities/person.dart';
import '../entities/travelStop.dart';
import '../entities/validator.dart';
import 'get_comments.dart';
import 'repositories/repository_comment.dart';
import 'repositories/repository_person.dart';
import 'repositories/repository_travel.dart';
import 'repositories/repository_travel_stop.dart';
import 'repositories/repository_user.dart';

/// get a list of travels from the current database
Future<(Validator, List<Travel>)> getTravelsUseCase(
    UserRepository userRepo,
    TravelRepository travelRepo,
    StopRepository stopRepo,
    PersonRepository personRepo,
    CommentRepository commentRepo
    ) async{

  var travelsList = <Travel>[];

  try{
    // get the userID
    final user = await userRepo.checkExistentUserDataBase();

    final userdId = user.$2?.userID;

    //get all the travels by user ID
    final travels = await travelRepo.getTravelsByUserId(userdId!);

    for (final storedTravel in travels){

      //transforms from map to entity
      final travel = Travel.fromMap(storedTravel);

      // add the stops to the travel
      final stops = await stopRepo.getStopsFromTravelID(travel.travelID!);
      for(final storedStop in stops){
        final stop = TravelStop.fromMap(storedStop);
        travel.travelStopList.add(stop);

        /// get the comments by stopID, relate with the person by ID,
        /// then add the comment entity into the stop
        final getComments = await getCommentsUseCase(
            stop.stopID!, commentRepo, personRepo
        );
        if(!getComments.$1.success){
          throw Exception('error on getting comments');
        }

        for(final comment in getComments.$2){
          stop.comments.add(comment);
        }

      }

      // add the persons to the travel
      final persons = await personRepo.getPersonsByTravelId(travel.travelID!);
      for(final storedPerson in persons){
        final person = Person.fromMap(storedPerson);
        travel.membersList.add(person);
      }

      //add into the list
      travelsList.add(travel);
    }

  } catch (e){
    return (Validator(false, 'error get_travels: $e'), travelsList);
  }

  return (Validator(true, null), travelsList);
}
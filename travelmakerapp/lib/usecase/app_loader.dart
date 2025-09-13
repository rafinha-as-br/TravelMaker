import 'package:travelmakerapp/entities/appState.dart';
import '../entities/validator.dart';
import 'package:travelmakerapp/usecase/check_location_service.dart';
import 'package:travelmakerapp/usecase/get_current_user.dart';
import 'package:travelmakerapp/usecase/repositories/location_service.dart';
import 'package:travelmakerapp/usecase/repositories/repository_user.dart';


Future <(AppStatus, Validator)> appLoaderUseCase (
    LocationService locationService,
    UserRepository userRepo
    ) async
{
  //checking user
  final getUser = await getCurrentUserUseCase(userRepo);
  if(getUser == null){
    return (AppStatus.userNotActive, Validator(false, 'userNotActive') );
  }

  //checking gps
  Validator gpsCheck = await checkLocationServiceUseCase(locationService);
  if(!gpsCheck.success){
    return (AppStatus.needGPS, gpsCheck);
  }

  return (AppStatus.ready, Validator(true, null));

}
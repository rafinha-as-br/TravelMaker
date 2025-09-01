

import 'package:geolocator/geolocator.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/usecase/repositories/location_service_Impl.dart';

Future<Validator> checkLocationServiceUseCase
  (
  LocationService locationService
  ) async
{
  /// check if the gps is active,
  /// if the user autorizes the GPS, continue
  /// if the user blocks the gps, open another screen that solicitates the GPS again

  bool serviceEnabled = await locationService.isServiceEnabled();
  if (!serviceEnabled){
    return Validator(false, 'Location service not enabled');
  }

  final permission = await locationService.checkPermission();
  if(permission == LocationPermission.denied){
    //get the localizationPermission denied for the first time
    final requested = await locationService.requestPermission();
    if(requested == LocationPermission.denied){
      return Validator(false, 'LocationPermissionDenied');
    }
    if(requested == LocationPermission.deniedForever){
      return Validator(false, 'LocationPermissionDeniedForever');
    }

  }

  return Validator(true, null);


}
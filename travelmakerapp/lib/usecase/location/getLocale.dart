import 'dart:ui';

import 'package:geocoding/geocoding.dart';
import 'package:travelmakerapp/usecase/location/getAdress.dart';
import 'package:travelmakerapp/usecase/location/getDeviceLocation.dart';

Future<Locale?> getLocale() async{
  Placemark? deviceLocation = await getDeviceLocation();
  print('Device location: ${deviceLocation!.street}' );
  if(deviceLocation == null){
    return null;
  } else{
    String countryCode = getCountry(deviceLocation);
    Locale locale = Locale(countryCode);
    return locale;
  }

}

// this function will only be used on the start up of the app
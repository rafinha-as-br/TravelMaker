import 'package:http/http.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/response.dart';
import 'package:travelmakerapp/entities/travelStop.dart';

class Travel{

  //from database
  int travelID;
  String travelName;
  String description;
  DateTime departure;
  DateTime arrival;
  String desiredVehicle;

  //on app
  List<TravelStop> travelStopList;
  List<Person> membersList;



  // travel title validator
  Validator travelTitleValidator(String? value){
    if(value==null) {return Validator(false, 'titleEmpty');}
    if(value.length<2){return Validator(false, 'titleShort');}
    return Validator(true, null);
  }

  // travel description validator
  Validator travelDescriptionValidator(String? value){
    if(value==null) {return Validator(false, 'descriptionEmpty');}
    if(value.length<2){return Validator(false, 'descriptionShort');}
    return Validator(true, null);
  }

  // travel destination validator
  Validator travelDestinationValidator(String? value){
    if(value==null){return Validator(false, 'cityEmpty');}
    return Validator(true, null);
  }



  // validate travel to create one
  Validator validateTravel(Travel travel){
    final travelTitleValidate = travelTitleValidator(travel.travelName);
    if(!travelTitleValidate.success){
      return travelTitleValidate;
    }

    final travelDescriptionValidate = travelDescriptionValidator(travel.description);
    if(!travelDescriptionValidate.success){
      return travelDescriptionValidate;
    }





    return Validator(true, null);

  }




}
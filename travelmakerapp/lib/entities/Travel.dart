import 'package:http/http.dart';
import 'package:travelmakerapp/entities/destination.dart';
import 'package:travelmakerapp/entities/finish.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

import 'experience.dart';
import 'origin.dart';

class Travel{

  //from database
  int? travelID;
  int? userID;
  String travelName;
  String description;
  Origin origin;
  Finish finish;
  Vehicles desiredVehicle;
  List<TravelStop> travelStopList;
  List<Person> membersList;
  List<Experiences> experiencesList;


  Travel(
      this.travelName, this.description,
      this.origin, this.finish,
      this.desiredVehicle, this.travelStopList,
      this.membersList, this.experiencesList
  );

  // travel title validator
  Validator travelTitleValidator(String value){
    if(value.isEmpty) {return Validator(false, 'titleEmpty');}
    if(value.length<2){return Validator(false, 'titleShort');}
    return Validator(true, null);
  }

  // travel description validator
  Validator travelDescriptionValidator(String value){
    if(value.isEmpty) {return Validator(false, 'descriptionEmpty');}
    if(value.length<2){return Validator(false, 'descriptionShort');}
    return Validator(true, null);
  }

  //validates the vehicles
  Validator travelVehicleValidator(Vehicles vehicle){
    if(vehicle == Vehicles.notSelected){return Validator(false, 'vehicleNotSelected');}
    return Validator(true, null);
  }

  // validate the origin
  Validator travelOriginValidator(Origin origin){
    final validate = origin.validateOrigin(origin);
    if(!validate.success){
      return validate;
    }

    return Validator(true, null);
  }

  //validate the finish
  Validator travelFinishValidator(Finish finish){
    final validate = finish.validateFinish(finish);
    if(!validate.success){
      return validate;
    }

    return Validator(true, null);
  }

  //validate the experiences
  Validator travelExperiencesValidator(List<Experiences> experiencesList){
    if(experiencesList.isEmpty){
      return Validator(false, 'experiencesListEmpty');
    }
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

    final travelVehicleValidate = travelVehicleValidator(travel.desiredVehicle);
    if(!travelVehicleValidate.success){
      return travelVehicleValidate;
    }

    final travelOriginValidate = travelOriginValidator(travel.origin);
    if(!travelOriginValidate.success){

      return travelOriginValidate;
    }

    final travelFinishValidate = travelFinishValidator(travel.finish);
    if(!travelFinishValidate.success){

      return travelFinishValidate;
    }

    final travelExperiencesValidate = travelExperiencesValidator(travel.experiencesList);
    if(!travelExperiencesValidate.success){
      return travelExperiencesValidate;
    }

    return Validator(true, null);

  }


  Map<String, dynamic> toMap(int userID) {
    return {
      'userID': userID,
      'travel_name': travelName,
      'travel_description': description,

      'travel_origin_city': origin.city,
      'travel_origin_lat': origin.latitude,
      'travel_origin_long': origin.longitude,
      'travel_origin_passed': origin.passed ? 1 : 0,

      'travel_finish_city': finish.city,
      'travel_finish_lat': finish.latitude,
      'travel_finish_long': finish.longitude,
      'travel_finish_passed': finish.passed ? 1 : 0,

      'departure': origin.departureDate.toIso8601String(),
      'arrival': finish.arrivalDate.toIso8601String(),

      'selected_vehicle': desiredVehicle.index,
    };
  }





}
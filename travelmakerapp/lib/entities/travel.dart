import 'experience.dart';
import 'finish.dart';
import 'origin.dart';
import 'person.dart';
import 'travel_status.dart';
import 'travel_stop.dart';
import 'travel_stop_status.dart';
import 'validator.dart';
import 'vehicles.dart';

/// travel entity, stores everything related of a travel
class Travel{

  ///from database
  int? travelID;

  /// userID that is passed on the insert on database method
  int? userID;

  /// travel title
  String travelName;
  /// travel description
  String description;

  /// travel origin point
  Origin origin;

  /// travel finish point
  Finish finish;

  /// main picture of the travel
  String? mainPicture;

  /// vehicle chosen for the travel
  Vehicles desiredVehicle;

  /// travel stop list
  List<TravelStop> travelStopList;

  /// participants on the travel
  List<Person> membersList;

  /// experiences from the travel
  List<Experiences> experiencesList;

  ///basic constructor
  Travel(
      this.travelName, this.description,
      this.origin, this.finish,
      this.desiredVehicle, this.travelStopList,
      this.membersList, this.experiencesList
  );

  /// travel title validator
  Validator travelTitleValidator(String value){
    if(value.isEmpty) {return Validator(false, 'titleEmpty');}
    if(value.length<2){return Validator(false, 'titleShort');}
    return Validator(true, null);
  }

  /// travel description validator
  Validator travelDescriptionValidator(String value){
    if(value.isEmpty) {return Validator(false, 'descriptionEmpty');}
    if(value.length<2){return Validator(false, 'descriptionShort');}
    return Validator(true, null);
  }

  ///validates the vehicles
  Validator travelVehicleValidator(Vehicles vehicle){
    if(vehicle == Vehicles.notSelected){
      return Validator(false, 'vehicleNotSelected');
    }
    return Validator(true, null);
  }

  /// validate the origin
  Validator travelOriginValidator(Origin origin){
    final validate = origin.validateOrigin(origin);
    if(!validate.success){
      return validate;
    }

    return Validator(true, null);
  }

  ///validate the finish
  Validator travelFinishValidator(Finish finish){
    final validate = finish.validateFinish(finish);
    if(!validate.success){
      return validate;
    }

    return Validator(true, null);
  }

  ///validate the experiences
  Validator travelExperiencesValidator(List<Experiences> experiencesList){
    if(experiencesList.isEmpty){
      return Validator(false, 'experiencesListEmpty');
    }
    return Validator(true, null);
  }



  /// validate travel to create one
  Validator validateTravel(Travel travel){
    final travelTitleValidate = travelTitleValidator(travel.travelName);
    if(!travelTitleValidate.success){

      return travelTitleValidate;
    }

    final travelDescriptionValidate = travelDescriptionValidator(
        travel.description
    );
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

    final travelExperiencesValidate = travelExperiencesValidator(
        travel.experiencesList
    );
    if(!travelExperiencesValidate.success){
      return travelExperiencesValidate;
    }

    return Validator(true, null);

  }


  /// check if the travel is completed
  TravelStatus checkTravelStatus(){

    /// travel can only be completed if the origin, stops and
    /// finish is completed


    /// check and update the origin status
    final today = DateTime.now();
    if(today.isAfter(origin.departureDate)){
      origin.passed = true;
    }

    if(today.isAfter(finish.arrivalDate)){
      finish.passed = true;
    }

    if(origin.passed){

      for(final stop in travelStopList) {
        final stopStatus = stop.checkStopStatus();
        if (
        stopStatus == TravelStopStatus.inProgress ||
            stopStatus == TravelStopStatus.notDone
        ) {
          return TravelStatus.inProgress;
        }
      }

      if(finish.passed){
        return TravelStatus.done;
      }

      return TravelStatus.inProgress;

    } else{
      return TravelStatus.notDone;
    }


  }

  /// travel to map method
  Map<String, dynamic> toMap(int userID) {
    return {
      'userID': userID,
      'travel_name': travelName,
      'travel_description': description,

      'travel_origin_city': origin.city,
      'travel_origin_lat': origin.latitude,
      'travel_origin_long': origin.longitude,
      'travel_origin_passed': origin.passed ? 1 : 0,
      'travel_main_picture' : mainPicture,

      'travel_finish_city': finish.city,
      'travel_finish_lat': finish.latitude,
      'travel_finish_long': finish.longitude,
      'travel_finish_passed': finish.passed ? 1 : 0,

      'departure': origin.departureDate.toIso8601String(),
      'arrival': finish.arrivalDate.toIso8601String(),

      'selected_vehicle': getVehicleId(desiredVehicle),
      'travel_experiences': serializeExperiences(experiencesList),

    };
  }

  /// travel from map
  factory Travel.fromMap(Map<String, dynamic> map) {
    final origin = Origin(
      city: map['travel_origin_city'],
      latitude: map['travel_origin_lat'],
      longitude: map['travel_origin_long'],
      passed: map['travel_origin_passed'] == 1,
      departureDate: DateTime.parse(map['departure']),
    );

    final finish = Finish(
      city: map['travel_finish_city'],
      latitude: map['travel_finish_lat'],
      longitude: map['travel_finish_long'],
      passed: map['travel_finish_passed'] == 1,
      arrivalDate: DateTime.parse(map['arrival']),
    );

    final travel = Travel(
      map['travel_name'],
      map['travel_description'],
      origin,
      finish,
      getVehicleById(map['selected_vehicle']),
      [],
      [],
      deserializeExperiences(map['travel_experiences']),
    );
    travel.mainPicture = map['travel_main_picture'];
    travel.travelID = map['travelID'];
    travel.userID = map['userID'];

    return travel;
  }

/// Convert a list of experiences into a comma-separated string (e.g. "1,3,5")
  static String serializeExperiences(List<Experiences> list) {
    return list.map(getExperienceId).join(',');
  }

/// Convert back from a string into a list of Experiences
  static List<Experiences> deserializeExperiences(String? text) {
    if (text == null || text.isEmpty) return [];
    return text
        .split(',')
        .map(getExperienceById)
        .toList();
  }


}
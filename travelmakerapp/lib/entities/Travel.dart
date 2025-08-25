import 'package:http/http.dart';
import 'package:travelmakerapp/entities/destination.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

import 'experience.dart';

class Travel{

  //from database
  int? travelID;
  String travelName;
  String description;
  Destination destination;
  DateTime departure;
  DateTime arrival;
  Vehicles desiredVehicle;
  List<TravelStop> travelStopList;
  List<Person> membersList;
  List<ExperiencesList> experiencesList;



  Travel(this.travelName, this.description, this.destination, this.departure, this.arrival,
      this.desiredVehicle, this.travelStopList,
      this.membersList, this.experiencesList);

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

  Validator travelVehicleValidator(Vehicles vehicle){
    if(vehicle == Vehicles.notSelected){return Validator(false, 'vehicleNotSelected');}
    return Validator(true, null);
  }

  Validator travelDatesValidator(DateTime departure, DateTime arrival){
    DateTime today = DateTime.now();
    if(departure.isBefore(today)){
      return Validator(false, 'departureDateBeforeToday');
    }
    if(arrival.isBefore(departure)){
      return Validator(false, 'arrivalDateBeforeDeparture');
    }
    return Validator(true, null);
  }

  Validator travelExperiencesValidator(List<ExperiencesList> experiencesList){
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

    final travelDestinationValidate = travel.destination.validateDestination(destination);
    if(!travelDestinationValidate.success){
      return travelDestinationValidate;
    }

    final travelVehicleValidate = travelVehicleValidator(travel.desiredVehicle);
    if(!travelVehicleValidate.success){
      return travelVehicleValidate;
    }

    final travelDatesValidate = travelDatesValidator(travel.departure, travel.arrival);
    if(!travelVehicleValidate.success){
      return travelDatesValidate;
    }

    final travelExperiencesValidate = travelExperiencesValidator(travel.experiencesList);
    if(!travelExperiencesValidate.success){
      return travelExperiencesValidate;
    }

    return Validator(true, null);

  }


}
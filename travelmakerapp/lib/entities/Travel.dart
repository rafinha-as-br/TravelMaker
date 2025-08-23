import 'package:http/http.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/entities/response.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

class Travel{

  //from database
  int? travelID;
  String travelName;
  String description;
  DateTime departure;
  DateTime arrival;
  Vehicles desiredVehicle;
  List<TravelStop> travelStopList;
  List<Person> membersList;


  Travel(this.travelName, this.description, this.departure, this.arrival,
      this.desiredVehicle, this.travelStopList,
      this.membersList); // travel title validator
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

  // travel destination validator
  Validator travelDestinationValidator(String value){
    if(value.isEmpty){return Validator(false, 'cityEmpty');}
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

    final travelDatesValidate = travelDatesValidator(travel.departure, travel.arrival);
    if(!travelVehicleValidate.success){
      return travelDatesValidate;
    }

    return Validator(true, null);

  }


}
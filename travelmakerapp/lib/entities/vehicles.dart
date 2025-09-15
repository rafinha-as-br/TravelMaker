/// vehicle enum, that contains the possibles vehicles that
/// can be used in a travel
enum Vehicles{
  /// car
  car,

  /// boat
  boat,

  /// train
  train,

  /// bus
  bus,

  /// airplane
  airplane,

  /// in case of not selected yet
  notSelected
}

/// to get from the database
Vehicles getVehicleById(int id){
  var vehicle = Vehicles.notSelected;

  switch(id){
    case 1:
      vehicle = Vehicles.car;
    case 2:
      vehicle = Vehicles.boat;
    case 3:
      vehicle = Vehicles.train;
    case 4:
      vehicle = Vehicles.bus;
    case 5:
      vehicle = Vehicles.airplane;
  }

  return vehicle;
}

/// to throw to the database
int getVehicleId(Vehicles vehicle){
  late int id;
  switch(vehicle){
    case Vehicles.car:
      id = 1;
    case Vehicles.boat:
      id = 2;
    case Vehicles.train:
      id = 3;
    case Vehicles.bus:
      id = 4;
    case Vehicles.airplane:
      id = 5;
    case Vehicles.notSelected:
      id = 0;
  }
  return id;
}
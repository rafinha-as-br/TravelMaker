enum Vehicles{
  car,
  boat,
  train,
  bus,
  airplane,
  notSelected
}

// to get from the database
Enum getVehicleById(String id){
  late Vehicles vehicle;

  switch(id){
    case '1':
      vehicle = Vehicles.car;
    case '2':
      vehicle = Vehicles.boat;
    case '3':
      vehicle = Vehicles.train;
    case '4':
      vehicle = Vehicles.bus;
    case '5':
      vehicle = Vehicles.airplane;
  }

  return vehicle;
}

// to throw to the database
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
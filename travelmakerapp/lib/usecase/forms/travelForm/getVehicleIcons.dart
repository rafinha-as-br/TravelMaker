import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/vehicles.dart';

IconData getVehicleIcons(Vehicles vehicle){
  switch (vehicle){
    case Vehicles.car:
      return Icons.directions_car_filled_sharp;
    case Vehicles.airplane:
      return Icons.airplanemode_on;
    case Vehicles.bus:
      return Icons.directions_bus_filled;
    case Vehicles.boat:
      return Icons.directions_boat;
    case Vehicles.train:
      return Icons.directions_train_rounded;
    case Vehicles.notSelected:
      return Icons.abc;
  }
}
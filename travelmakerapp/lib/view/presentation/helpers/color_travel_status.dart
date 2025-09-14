import 'package:flutter/material.dart';

import '../../../entities/travel_status.dart';

/// returns a color based from the enum status of the travel
Color getColorByTravelStatus(TravelStatus travelStatus){
  switch(travelStatus){
    case TravelStatus.notDone:
      return Colors.red;
    case TravelStatus.inProgress:
      return Colors.yellowAccent;
    case TravelStatus.done:
      return Colors.green;
  }
}
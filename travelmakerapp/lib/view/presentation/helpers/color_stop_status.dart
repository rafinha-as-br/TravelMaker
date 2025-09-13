
import 'package:flutter/material.dart';

import '../../../entities/travel_stop_status.dart';

Color getColorByStopStatus(TravelStopStatus stopStatus){
  switch(stopStatus){
    case TravelStopStatus.notDone:
      return Colors.red;
    case TravelStopStatus.inProgress:
      return Colors.yellowAccent;
    case TravelStopStatus.done:
      return Colors.green;
  }
}
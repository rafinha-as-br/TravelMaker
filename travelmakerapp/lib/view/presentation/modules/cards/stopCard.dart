import 'package:flutter/material.dart';
import '../../../../entities/travelStop.dart';
 import '../../../../entities/travel_stop_status.dart';
import '../../../services/map_service.dart';
import '../../helpers/color_stop_status.dart';

/// the card that shows a resumed TravelStop info from a list
class StopCard extends StatelessWidget {
  ///
  const StopCard({
    super.key,
    required this.travelStop,
    required this.index,
    required this.stopStatus
  });

  /// the travelStop that is going to be shown
  final TravelStop travelStop;

  /// the status of this travelStop
  final TravelStopStatus stopStatus;

  /// the index from the list to get the correct stop number
  final int index;


  @override
  Widget build(BuildContext context) {



    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color:  Theme.of(context).canvasColor,
      margin: EdgeInsets.zero,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //background image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)
                )
              ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)
                  ),
                  child: Image.network(
                    MapService.staticMapURL(
                        travelStop.destination.latitude.toDouble(),
                        travelStop.destination.longitude.toDouble()
                    ),
                  ),
                )
            ),
        
            //bottom
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: getColorByStopStatus(stopStatus),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 15,),
                  Text(
                    "Parada ${index+1} - "
                    "${travelStop.destination.city.split(',')[0].trim() }",
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

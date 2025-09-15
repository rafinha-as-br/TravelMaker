import 'package:flutter/material.dart';
import '../../../../entities/travel.dart';
import '../../../../entities/travel_status.dart';
import '../../../services/map_service.dart';
import '../../helpers/color_travel_status.dart';
import '../../page/screen_travel_view.dart';

/// card widget that shows some stop infos
class TravelCard extends StatelessWidget {
  ///
  const TravelCard({
    super.key,
    required this.travel,
    required this.travelStatus
  });

  /// travel that is going to be shown by de card
  final Travel travel;
  final TravelStatus travelStatus;

  /// receiving the index to show the correct travel

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color:  Theme.of(context).canvasColor,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                TravelScreen(
                    travel: travel
                )
            )
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            ///background image or view of the Map
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
                  MapService.staticMapRouteURL(travel),
                ),
              )
            ),

            ///bottom
            Container(
              height: 50,
                decoration: BoxDecoration(
                  color: getColorByTravelStatus(travelStatus),
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
                    "${travel.travelName} - ${travel.finish.city}",
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );;
  }
}

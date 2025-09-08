import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/Travel.dart';

import '../../../services/maps_api.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({super.key, required this.travel, required this.index});

  final Travel travel;
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
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  child: Image.network(
                    staticMapURL(travelStop.destination.latitude, travelStop.destination.longitude),
                  ),
                )
            ),

            //bottom
            Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 15,),
                    Text(
                      "Parada ${index+1} - ${travelStop.destination.city.split(',')[0].trim() }",
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

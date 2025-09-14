import 'package:flutter/material.dart';

import '../../../../../../entities/Travel.dart';
import '../../../../../services/map_service.dart';
import '../../container_customContainer.dart';

class TravelMapViewContainer extends StatelessWidget {
  const TravelMapViewContainer({super.key, required this.travel});

  final Travel travel;

  @override
  Widget build(BuildContext context) {
    return CustomContainer1(
        widget: Column(
          spacing: 10,
          children: [
            Text(
              "Mapa da viagem",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15)
              ),
              child: Image.network(
                MapService.staticMapRouteURL(travel),
              ),
            )
          ],
        )
    );
  }
}

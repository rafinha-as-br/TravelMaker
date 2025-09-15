import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../entities/travel.dart';
import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../../../../services/map_service.dart';
import '../../container_customContainer.dart';

/// this widget shows a map of a travel
class TravelMapViewContainer extends StatelessWidget {
  const TravelMapViewContainer({super.key});


  @override
  Widget build(BuildContext context) {
    final tvp = Provider.of<TravelViewProvider>(context);

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
                MapService.staticMapRouteURL(tvp.travel),
              ),
            )
          ],
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../container_customContainer.dart';

/// this widget returns a container that shows the travel destination
class TravelDestinationViewContainer extends StatelessWidget {
  ///
  const TravelDestinationViewContainer({super.key});
  /// the destination text required

  @override
  Widget build(BuildContext context) {
    final tvp = Provider.of<TravelViewProvider>(context);


    return CustomContainer1(
        widget: Row(
          children: [
            Text(
              "Destino final: ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              tvp.travel.finish.city,
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.fade,
            )
          ],
        ),
    );
  }
}

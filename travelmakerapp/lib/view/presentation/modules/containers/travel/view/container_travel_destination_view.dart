import 'package:flutter/material.dart';

import '../../container_customContainer.dart';

/// this widget returns a container that shows the travel destination
class TravelDestinationViewContainer extends StatelessWidget {
  ///
  const TravelDestinationViewContainer({super.key, required this.destination});
  /// the destination text required
  final String destination;

  @override
  Widget build(BuildContext context) {
    return CustomContainer1(
        widget: Row(
          children: [
            Text(
              "Destino final: ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              destination,
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.fade,
            )
          ],
        ),
    );
  }
}

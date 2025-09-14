import 'package:flutter/material.dart';

import '../../../../../../entities/destination.dart';
import '../../../../../../entities/travelStop.dart';
import '../../container_customContainer.dart';

/// container widget that shows the destination of a stop
class StopCityViewContainer extends StatelessWidget {

  ///
  const StopCityViewContainer({super.key, required this.destination});

  /// the destination to be shown
  final Destination destination;

  @override
  Widget build(BuildContext context) {

    return CustomContainer1(
        widget: Column(
          children: [
            Text(
              destination.city,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              '${destination.latitude}, ${destination.longitude}',
              style: Theme.of(context).textTheme.displaySmall,
            )
          ],
        )
    );
  }
}

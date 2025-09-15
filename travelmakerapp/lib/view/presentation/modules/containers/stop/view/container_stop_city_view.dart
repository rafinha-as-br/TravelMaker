import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../entities/destination.dart';
import '../../../../../../entities/travel_stop.dart';
import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../container_customContainer.dart';

/// container widget that shows the destination of a stop
class StopCityViewContainer extends StatelessWidget {

  ///
  const StopCityViewContainer({super.key, required this.destination});

  /// the destination to be shown
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    final tvp = Provider.of<TravelViewProvider>(context);

    return CustomContainer1(
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
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
          ),
        )
    );
  }
}

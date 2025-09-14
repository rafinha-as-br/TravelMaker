import 'package:flutter/material.dart';

import '../../../../../../entities/travelStop.dart';
import '../../../dateDisplayer.dart';
import '../../container_customContainer.dart';

/// this widget returns a dateTime comparable view to show the 
/// time spent on a TravelStop
class StopTimeSpentViewContainer extends StatelessWidget {
  ///
  const StopTimeSpentViewContainer({super.key, required this.stop});

  ///the travelStop with the dates Data
  final TravelStop stop;

  @override
  Widget build(BuildContext context) {
    return CustomContainer1(
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            spacing: 10,
            children: [
              Text(
                'Tempo gasto na parada ',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              DateDisplayer(stop.arrival, stop.departure, context)
            ],
          ),
        )
    );
  }
}

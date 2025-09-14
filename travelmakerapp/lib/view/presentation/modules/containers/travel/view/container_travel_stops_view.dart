import 'package:flutter/material.dart';

import '../../../../../../entities/travelStop.dart';
import '../../../customExpansionTile.dart';
import '../../../listViews/list_view_travel_stop.dart';
import '../../container_customContainer.dart';

/// this widget returns a container that shows the stops by
/// a stopList
class TravelStopsViewContainer extends StatelessWidget {
  ///
  const TravelStopsViewContainer({
    super.key, required this.stopList
  });

  /// stop list to be shown
  final List<TravelStop> stopList;

  @override
  Widget build(BuildContext context) {
    return Customexpansiontile2(
        title: "Paradas da viagem",
        widget: TravelStopListView(
            onTap: (_){

            },
            travelStopList: stopList
        ),
        initiallyExpanded: true
    );
  }
}

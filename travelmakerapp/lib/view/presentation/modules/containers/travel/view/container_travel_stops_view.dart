import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../../customExpansionTile.dart';
import '../../../listViews/list_view_travel_stop.dart';

/// this widget returns a container that shows the stops by
/// a stopList
class TravelStopsViewContainer extends StatelessWidget {
  ///
  const TravelStopsViewContainer({super.key});


  @override
  Widget build(BuildContext context) {
    final tvp = Provider.of<TravelViewProvider>(context);
    final stopList = tvp.travel.travelStopList;

    return Customexpansiontile2(
        title: 'Paradas da viagem',
        widget: TravelStopListView(
          travelStopList: stopList,
          tvp: tvp,
        ),
        initiallyExpanded: true
    );
  }
}

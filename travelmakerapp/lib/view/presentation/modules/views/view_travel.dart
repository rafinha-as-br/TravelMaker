import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../interface_adapters/providers/provider_travel_view.dart';
import '../appBars/sliver_app_bar_travel_view.dart';
import '../buttons/customButton.dart';
import '../containers/travel/view/container_travel_dates_view.dart';
import '../containers/travel/view/container_travel_destination_view.dart';
import '../containers/travel/view/container_travel_experiences_view.dart';
import '../containers/travel/view/container_travel_map_view.dart';
import '../containers/travel/view/container_travel_participants_view.dart';
import '../containers/travel/view/container_travel_stops_view.dart';
import '../containers/travel/view/container_travel_vehicle_view.dart';

/// this widget call all the necessary container to show a travel
class TravelView extends StatelessWidget {
  ///
  const TravelView({super.key});

  @override
  Widget build(BuildContext context) {
    /// the travelViewProvider, here, we're calling him as tvp for better
    /// reading
    final tvp = Provider.of<TravelViewProvider>(context);


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TravelViewSliverAppBar(travel: tvp.travel),
          SliverToBoxAdapter(
            child: Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal: 12, vertical: 18
              ),
              child: Column(
                spacing: 20,
                children: [

                  /// destination
                  TravelDestinationViewContainer(),

                  /// travel map
                  TravelMapViewContainer(),

                  /// Start And conclusion days
                  TravelDatesViewContainer(),

                  /// selected way of transport
                  TravelVehicleViewContainer(),

                  /// Participants
                  TravelParticipantsViewContainer(),

                  /// StopList
                  TravelStopsViewContainer(),

                  /// Experience list
                  TravelExperiencesViewContainer(),

                  /// TODO conclude travel button
                  MediumButton3(
                      onTap: (){},
                      text: 'Concluir viagem',
                      icon: Icons.check
                  ),

                  /// TODO GENERATE BOOKLET
                  MediumButton3(
                      onTap: tvp.generateBooklet,
                      text: 'Gerar livreto',
                      icon: Icons.book
                  ),

                  /// just to get better visualization
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

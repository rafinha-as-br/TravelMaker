import 'dart:io';
import 'package:flutter/material.dart';
import '../../../entities/Travel.dart';
import '../../../l10n/app_localizations.dart';
import '../helpers/dates/dateFormat.dart';
import '../helpers/getVehicleName.dart';
import '../modules/appBars/sliver_app_bar_travel_view.dart';
import '../modules/cards/stopCard.dart';
import '../modules/containers/travel/view/container_travel_dates_view.dart';
import '../modules/containers/travel/view/container_travel_destination_view.dart';
import '../modules/containers/travel/view/container_travel_vehicle_view.dart';
import '../modules/inputDecoration.dart';
import '../modules/listViews/list_view_travel_participants.dart';
import '../modules/listViews/list_view_travel_stop.dart';

/// This screen is to visualize an specific travel and it's info
class TravelScreen extends StatelessWidget {
  ///
  const TravelScreen({super.key, required this.travel});

  /// travel that is going to be visualized
  final Travel travel;


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TravelViewSliverAppBar(travel: travel),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                spacing: 20,
                children: [

                  /// destination
                  TravelDestinationViewContainer(
                      destination: travel.finish.city
                  ),

                  /// TODO Travel map (widget)
                  ///


                  /// Start And conclusion days
                  TravelDatesViewContainer(
                      start: travel.origin.departureDate,
                      finish: travel.finish.arrivalDate
                  ),

                  /// selected way of transport
                  TravelVehicleViewContainer(vehicle: travel.desiredVehicle),

                  /// Participants
                  Column(
                    children: [
                      Text(
                        "Participantes",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(
                        width: 200,
                        height: 150,
                        child:
                        TravelParticipantsListView(
                            membersList: travel.membersList
                        )
                      )
                    ],
                  ),

                  /// StopList
                  TravelStopListView(
                      onTap: (_){

                      },
                      travelStopList: travel.travelStopList
                  )

                  /// TODO conclude travel button

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

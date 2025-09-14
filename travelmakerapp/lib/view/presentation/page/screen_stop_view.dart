import 'package:flutter/material.dart';

import '../../../entities/travelStop.dart';
import '../modules/appBars/sliver_app_bar_stop_view.dart';
import '../modules/containers/stop/view/container_stop_city_view.dart';
import '../modules/containers/stop/view/container_stop_comments_view.dart';
import '../modules/containers/stop/view/container_stop_dates_view.dart';
import '../modules/containers/stop/view/container_stop_time_spent_view.dart';

/// this screen is destinated to show a determinated TravelStop
class StopViewScreen extends StatelessWidget {
  ///
  const StopViewScreen({super.key, required this.stop, required this.index});

  /// The TravelStop to be shown
  final TravelStop stop;
  /// index from the list
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          StopViewSliverAppBar(stop: stop, index: index,),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                spacing: 15,
                children: [

                  /// stop city
                  StopCityViewContainer(destination: stop.destination),

                  /// dates
                  StopDatesViewContainer(
                      arrival: stop.arrival!, departure: stop.departure!
                  ),

                  /// time spent
                  StopTimeSpentViewContainer(
                      stop: stop
                  ),
                  
                  /// stop comments
                  StopCommentsContainer(comments: stop.comments),

                  SizedBox(
                    height: 50,
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

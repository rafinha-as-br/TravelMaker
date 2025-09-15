import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../entities/travel_stop.dart';
import '../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../page/screen_stop_view.dart';
import '../cards/stopCard.dart';

/// A listView widget that show a list of StopCards from a TravelStop list
class TravelStopListView extends StatelessWidget {
  ///
  const TravelStopListView({
    super.key,
    required this.travelStopList,
    required this.tvp
  });

  /// the stopList
  final List<TravelStop> travelStopList;
  final TravelViewProvider tvp;


  @override
  Widget build(BuildContext context) {


    return ListView.builder(
        itemCount: travelStopList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          final stop = travelStopList[index];
          final stopStatus = stop.checkStopStatus();
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) =>
                     ChangeNotifierProvider.value(
                       value: tvp,
                       child: StopViewScreen(
                         stop: stop,
                         index: index,
                         tvp: tvp
                       )
                     )
                 )
               );
              },
              title: StopCard(
                travelStop: stop,
                index: index,
                stopStatus: stopStatus,
              ),
            ),
          );
        }
    );
  }
}

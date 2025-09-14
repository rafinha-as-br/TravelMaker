import 'package:flutter/material.dart';

import '../../../../entities/travelStop.dart';
import '../../page/screen_stop_view.dart';
import '../cards/stopCard.dart';

/// A listView widget that show a list of StopCards from a TravelStop list
class TravelStopListView extends StatelessWidget {
  ///
  const TravelStopListView({
    super.key,
    required this.travelStopList
  });

  final List<TravelStop> travelStopList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: travelStopList.length,
        shrinkWrap: true,
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
                      StopViewScreen(
                          stop: stop, index: index
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

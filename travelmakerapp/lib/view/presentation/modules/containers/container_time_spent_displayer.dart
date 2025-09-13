import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/provider_create_travel.dart';
import '../dateDisplayer.dart';
import 'container_customContainer.dart';

class StopTimeSpentContainer extends StatelessWidget {
  const StopTimeSpentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        Column(
          children: [
            Row(
              spacing: 15,
              children: [
                Icon(Icons.timelapse, color: Theme.of(context).primaryColor, size: 35,),
                Text("Tempo gasto previsto", style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).primaryColor,),
          ],
        ),
        dateDisplayer(
            createTravelProvider.sfc!.stopArrivalDate,
            createTravelProvider.sfc!.stopDepartureDate,
            context
        )
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../inputDecoration.dart';
import 'container_customContainer.dart';

class StopDateSelectorContainer extends StatelessWidget {
  const StopDateSelectorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 15,
              children: [
                Icon(Icons.edit_calendar, color: Theme.of(context).primaryColor, size: 35,),
                Text("Datas de chegada e partida", style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).primaryColor,),
            Text("Toda parada você tem um dia para chegar e ir embora, qual são esses dias?", style: Theme.of(context).textTheme.displaySmall,)
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            spacing: 30,
            children: [
              Expanded(
                  child: TextFormField(
                      decoration: getInputDecoration("Data chegada", context),
                      style: Theme.of(context).textTheme.displaySmall,
                      controller: createTravelProvider.sfc!.stopArrivalController,
                      readOnly: true,

                      onTap: (){
                        createTravelProvider.sfc!.selectStopArrivalDate(context);
                      }
                  )

              ),
              Expanded(
                  child: TextFormField(
                      decoration: getInputDecoration("Data saída", context),
                      style: Theme.of(context).textTheme.displaySmall,
                      controller: createTravelProvider.sfc!.stopDepartureController,
                      readOnly: true,

                      onTap: (){
                        createTravelProvider.sfc!.selectStopDepartureDate(context);
                      }
                  )
              ),
            ],
          ),
        )
      ],
    ));
  }
}

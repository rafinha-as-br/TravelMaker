import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../entities/vehicles.dart';
import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../../../helpers/getVehicleName.dart';
import '../../../inputDecoration.dart';
import '../../container_customContainer.dart';

/// this widget returns the selected vehicle for a travel
class TravelVehicleViewContainer extends StatelessWidget {
  ///
  const TravelVehicleViewContainer({super.key});


  @override
  Widget build(BuildContext context) {
    final tvp = Provider.of<TravelViewProvider>(context);
    final vehicle = tvp.travel.desiredVehicle;


    return CustomContainer1(
        widget: Row(
          spacing: 25,
          children: [
            Text(
              'Meio de transporte',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: TextField(
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: getInputDecoration(
                    getVehicleName(vehicle, context),
                    context
                ),
              ),
            )
          ],
        )
    );
  }
}

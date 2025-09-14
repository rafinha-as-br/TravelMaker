import 'package:flutter/material.dart';

import '../../../../../../entities/vehicles.dart';
import '../../../../helpers/getVehicleName.dart';
import '../../../inputDecoration.dart';
import '../../container_customContainer.dart';

/// this widget returns the selected vehicle for a travel
class TravelVehicleViewContainer extends StatelessWidget {
  ///
  const TravelVehicleViewContainer({super.key, required this.vehicle});

  final Vehicles vehicle;

  @override
  Widget build(BuildContext context) {
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

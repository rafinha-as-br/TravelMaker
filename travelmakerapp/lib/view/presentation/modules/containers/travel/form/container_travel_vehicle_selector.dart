import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../entities/vehicles.dart';
import '../../../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../helpers/getVehicleIcons.dart';
import '../../../../helpers/getVehicleName.dart';
import '../../../customExpansionTile.dart';
import '../../container_customContainer.dart';

class VehicleSelectorContainer extends StatelessWidget {
  const VehicleSelectorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 15,
              children: [
                Icon(Icons.emoji_transportation, color: Theme.of(context).primaryColor,),
                Text(AppLocalizations.of(context)!.desiredTransportTitle, style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).primaryColor,),
            Text(AppLocalizations.of(context)!.desiredTransportText, style: Theme.of(context).textTheme.displaySmall,)
          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Consumer<CreateTravelProvider>(builder: (context, p, child){
              return Customexpansiontile(
                // bool to close the expansion tile when ListTileSelected
                key: ValueKey(p.isVehicleExpanded),
                title: p.vehicleChosen == Vehicles.notSelected ?
                AppLocalizations.of(context)!.vehicles :
                "${AppLocalizations.of(context)!.chosenMean} ${getVehicleName(p.vehicleChosen, context)}",
                initiallyExpanded: p.isVehicleExpanded,
                widget: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Vehicles.values.length-1,
                  itemBuilder: (context, index){
                    final vehicle = Vehicles.values[index];

                    return ListTile(
                        title: Container(
                          width: 100,
                          height: 40,
                          decoration: p.vehicleChosen == vehicle ?
                          BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ): null,
                          child: InkWell(
                            onTap: (){
                              p.selectVehicle(vehicle);
                              p.toggleVehicleExpanded(expanded: false);
                            },
                            child: Row(
                              spacing: 10,
                              children: [
                                SizedBox(width: 10,),
                                Text(getVehicleName(vehicle, context), style: Theme.of(context).textTheme.displaySmall,),
                                Icon(getVehicleIcons(vehicle), color: Theme.of(context).primaryColor,)
                              ],
                            ),
                          ),
                        )
                    );
                  },
                ),
              );
            }

            )
        )
      ],
    ));
  }
}

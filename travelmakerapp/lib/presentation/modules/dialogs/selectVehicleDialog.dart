import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/customDialog.dart';

import '../../../Themes/getTheme.dart';
import '../../../entities/vehicles.dart';
import '../../../l10n/app_localizations.dart';
import '../../../usecase/forms/travelForm/getVehicleIcons.dart';
import '../../../usecase/forms/travelForm/getVehicleName.dart';
import '../../provider/personProvider.dart';
import '../customExpansionTile.dart';

class SelectVehicleDialog extends StatelessWidget {
  const SelectVehicleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: "Selecionando veículos",
        widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Consumer<PersonProvider>(builder: (context, p, child){
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
                              border: Border.all(color: getPrimaryColor(), width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ): null,
                          child: InkWell(
                            onTap: (){
                              p.selectVehicle(vehicle);
                              p.toggleVehicleExpanded(false);
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              spacing: 10,
                              children: [
                                SizedBox(width: 10,),
                                Text(getVehicleName(vehicle, context), style: Theme.of(context).textTheme.displaySmall,),
                                Icon(getVehicleIcons(vehicle), color: getPrimaryColor(),)
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
        ,
        onClose: (){
          Navigator.of(context).pop();

        }
    );
  }
}

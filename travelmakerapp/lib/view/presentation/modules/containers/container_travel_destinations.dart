import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../customTextFormField.dart';
import 'container_customContainer.dart';

class TravelDestinationsContainer extends StatelessWidget {
  const TravelDestinationsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 20,
      children: [
        CustomSubContainer1(
            text1: AppLocalizations.of(context)!.finalDestinationTitle,
            text2: AppLocalizations.of(context)!.finalDestination,
            icon: Icons.my_location
        ),

        // start city textField
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 5,
            children: [
              Text("Qual a cidade de partida?", style: Theme.of(context).textTheme.displayMedium,),
              CustomTextFormField2(
                controller: ctp.tfc!.travelOriginCityController,
                onSelect: (suggestion) {
                  ctp.tfc!.selectTravelOriginCity(suggestion);

                },
              ),
            ],
          ),
        ),

        // final city textField
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 5,
            children: [
              Text("Qual o destino final?", style: Theme.of(context).textTheme.displayMedium),
              CustomTextFormField2(
                controller: ctp.tfc!.travelFinishCityController,
                onSelect: (suggestion) {
                  ctp.tfc!.selectTravelFinishCity(suggestion);
                },
              ),
            ],
          ),
        ),

      ],
    ),
    );
  }
}

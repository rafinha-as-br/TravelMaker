import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../customTextFormField.dart';
import '../container_customContainer.dart';

class StopCityContainer extends StatelessWidget {
  const StopCityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        CustomSubContainer1(
            text1: 'Cidade da parada',
            text2: 'Escolha uma cidade para visitar ou conhecer!',
            icon: Icons.location_city
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextFormField2(
                controller: createTravelProvider.sfc!.stopDestinationController,
                onSelect: (suggestion) {
                  createTravelProvider.sfc!.selectStopCity(suggestion);

                  FocusScope.of(context).unfocus();
                }
            )
        )
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../customTextFormField.dart';
import '../../container_customContainer.dart';

class TravelDescriptionContainer extends StatelessWidget {
  const TravelDescriptionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        CustomSubContainer1(
            text1: AppLocalizations.of(context)!.giveTravelDescription,
            text2: AppLocalizations.of(context)!.travelDescriptionText,
            icon: Icons.short_text
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextFormField3(
            title: AppLocalizations.of(context)!.description,
            controller: ctp.tfc!.travelDescriptionController,
          ),
        )
      ],
    ),
    );
  }
}

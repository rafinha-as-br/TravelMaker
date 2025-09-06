import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../customTextFormField.dart';
import 'customContainer.dart';

class TravelTitleContainer extends StatelessWidget {
  const TravelTitleContainer({super.key});


  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        CustomSubContainer1(
            text1: AppLocalizations.of(context)!.giveTravelTitle,
            text2: AppLocalizations.of(context)!.travelTitleText,
            icon: Icons.text_fields
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextFormField1(
            title: AppLocalizations.of(context)!.title,
            controller: ctp.travelTitleController,
            formFieldKey: ctp.travelTitleFormFieldKey,
          ),
        )
      ],
    ),);
  }
}

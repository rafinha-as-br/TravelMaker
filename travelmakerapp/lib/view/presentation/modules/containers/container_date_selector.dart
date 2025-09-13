import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../../l10n/app_localizations.dart';
import '../inputDecoration.dart';
import 'container_customContainer.dart';

class DateSelectorContainer extends StatelessWidget {
  const DateSelectorContainer({super.key});

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
                Icon(Icons.date_range, color: Theme.of(context).primaryColor,),
                Text(AppLocalizations.of(context)!.startEndDate, style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).primaryColor,),
            Text(AppLocalizations.of(context)!.startEndDateText, style: Theme.of(context).textTheme.displaySmall,)

          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            spacing: 45,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: getInputDecoration(AppLocalizations.of(context)!.startDate, context),
                  style: Theme.of(context).textTheme.displaySmall,
                  readOnly: true,
                  controller: ctp.tfc!.travelOriginDepartureController,
                  onTap: (){
                    ctp.tfc!.selectTravelOriginDate(context);
                  },
                ),

              ),
              Expanded(
                child: TextFormField(
                  decoration: getInputDecoration(AppLocalizations.of(context)!.endDate, context),
                  style: Theme.of(context).textTheme.displaySmall,
                  readOnly: true,
                  controller: ctp.tfc!.travelFinishArrivalController,
                  onTap: (){
                    ctp.tfc!.selectTravelFinishDate(context);
                  },
                ),

              ),
            ],
          ),
        ),

      ],
    ));
  }
}

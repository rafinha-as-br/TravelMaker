import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../../l10n/app_localizations.dart';
import '../buttons/customButton.dart';
import '../chips/customChip.dart';
import '../dialogs/experienceDialog.dart';
import 'container_customContainer.dart';

class AddExperienceContainer extends StatelessWidget {
  const AddExperienceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        Column(
          children: [
            Row(
              spacing: 15,
              children: [
                Icon(Icons.bookmark_add, color: Theme.of(context).primaryColor, size: 35,),
                Text(AppLocalizations.of(context)!.experiences, style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).primaryColor,),
            Text(AppLocalizations.of(context)!.experiencesText, style: Theme.of(context).textTheme.displaySmall,)
          ],
        ),

        // experiences list
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Wrap(
            spacing: 8,
            runSpacing: 1,
            children: ctp.experiencesList.isEmpty ?
            [Text(AppLocalizations.of(context)!.experiencesEmpty, style: Theme.of(context).textTheme.displaySmall, )] :
            ctp.experiencesList.map((experience) {
              bool isSelected = ctp.experiencesList.contains(experience);
              return ExperienseChip(experience.name, isSelected, context);
            }).toList(),
          ),
        ),

        // add experience (call a dialog)
        Row(
          children: [
            Expanded(
              child: SmallButton1(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) => ExperienceDialog()
                    );
                  },
                  text: AppLocalizations.of(context)!.addExperience,
                  icon: Icons.airline_stops_rounded),
            ),
          ],
        )

      ],
    ));
  }
}

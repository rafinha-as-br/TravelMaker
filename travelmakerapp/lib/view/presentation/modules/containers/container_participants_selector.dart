import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../../interface_adapters/providers/personProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../buttons/customButton.dart';
import '../customExpansionTile.dart';
import '../customListView.dart';
import '../dialogs/participantDialog.dart';
import 'container_customContainer.dart';

class ParticipantsSelectorContainer extends StatelessWidget {
  const ParticipantsSelectorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);
    final personProvider = Provider.of<PersonProvider>(context);


    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [

        //header
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 15,
              children: [
                Icon(Icons.person_add, color: Theme.of(context).primaryColor,),
                Text(AppLocalizations.of(context)!.addParticipants, style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).primaryColor,),
            Text(AppLocalizations.of(context)!.addParticipantsText, style: Theme.of(context).textTheme.displaySmall,)
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Customexpansiontile(
            title: AppLocalizations.of(context)!.participants,
            initiallyExpanded: true,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Participants
                CustomListView1(
                    personsList: ctp.travelPersonsList,
                    editOnTap: (index){
                      //toogle edit mode
                      personProvider.toogleEditPersonMode(true);
                      // set the person that is going to be edited
                      personProvider.setPersonToEdit(ctp.travelPersonsList[index], index);
                      // call the person dialog
                      showDialog(
                          context: context,
                          builder: (context) => ParticipantDialog(createTravelProvider: ctp)
                      );
                    },
                    removeOnTap: (index) {
                      ctp.removePerson(index);

                    }
                ),

                // add participants button
                Row(
                  children: [
                    Expanded(
                      child: SmallButton1(
                          onTap: (){
                            showDialog(
                              context: context,
                                builder: (context) => ParticipantDialog(createTravelProvider: ctp)
                            );
                          },
                          text: AppLocalizations.of(context)!.addParticipantsButtonText,
                          icon: Icons.add
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

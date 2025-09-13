import 'package:flutter/material.dart';

import '../../../../entities/person.dart';
import '../../../../l10n/app_localizations.dart';
import '../circleAvatars/circle_avatar_person.dart';

///used for view current persons in a Person List, used in TravelForm
class TravelParticipantsListViewEditable extends StatelessWidget {
  ///used for travelParticipants view
  const TravelParticipantsListViewEditable({
    super.key, required this.personsList,
    required this.editAction, required this.removeAction
  });

  /// the list of persons to be shown
  final List<Person> personsList;

  /// the action to edit the person when the user touches edit icon
  final void Function(int index) editAction;

  /// the action to remove the person when the user touches the remove icon
  final void Function(int index) removeAction;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: personsList.length,
      itemBuilder: (context, index) {
        final person = personsList[index];

        return Container(
          height: 35,
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PersonCircleAvatar(person: person),
                  SizedBox(width: 5,),
                  //name
                  Text(
                    '${person.name}, ',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  //age
                  Text(
                    '${person.age.toString()}'
                    ' ${AppLocalizations.of(context)!.years}',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),

              //actions buttons (the first on is always the user
              if(index != 0) ...[
                Row(
                  children: [
                    VerticalDivider(
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
                    ),

                    // edit person button
                    IconButton(
                      onPressed: () => editAction(index),
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      padding: EdgeInsetsGeometry.zero,
                      constraints: BoxConstraints(),
                    ),

                    //remove person button
                    IconButton(
                      onPressed: () => removeAction(index),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      padding: EdgeInsetsGeometry.zero,
                      constraints: BoxConstraints(),

                    ),
                  ],
                )
              ]

            ],
          ),
        );
      },
    );
  }
}




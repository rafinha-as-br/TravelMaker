import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../entities/person.dart';
import '../../../../l10n/app_localizations.dart';
import '../circleAvatars/circle_avatar_person.dart';

/// this widget displays a listview of persons that is not editable
class TravelParticipantsListView extends StatelessWidget {
  ///
  const TravelParticipantsListView({super.key, required this.membersList});

  final List<Person> membersList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( /// TODO: REFACTOR INTO ANOTHER WIDGET
        itemCount: membersList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          final person = membersList[index];
          return Row(
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
          );
        }
    );
  }
}

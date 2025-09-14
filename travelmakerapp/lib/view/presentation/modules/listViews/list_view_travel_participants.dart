import 'package:flutter/material.dart';
import '../../../../entities/person.dart';
import '../../../../l10n/app_localizations.dart';
import '../circleAvatars/circle_avatar_person.dart';

/// this widget displays a listview of persons that is not editable
class TravelParticipantsListView extends StatelessWidget {
  ///
  const TravelParticipantsListView({super.key, required this.membersList});

  /// list of persons to be shown
  final List<Person> membersList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( /// TODO: REFACTOR INTO ANOTHER WIDGET
        itemCount: membersList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          final person = membersList[index];
          return Container(
            height: 35,
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
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
          );
        }
    );
  }
}

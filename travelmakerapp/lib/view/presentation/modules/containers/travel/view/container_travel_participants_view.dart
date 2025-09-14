import 'package:flutter/material.dart';

import '../../../../../../entities/person.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../customExpansionTile.dart';
import '../../../listViews/list_view_travel_participants.dart';
import '../../container_customContainer.dart';

class ParticipantsViewContainer extends StatelessWidget {
  const ParticipantsViewContainer({super.key, required this.memberList});

  final List<Person> memberList;

  @override
  Widget build(BuildContext context) {
    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TravelParticipantsListView(membersList: memberList)
        ),
      ],
    ));
  }
}

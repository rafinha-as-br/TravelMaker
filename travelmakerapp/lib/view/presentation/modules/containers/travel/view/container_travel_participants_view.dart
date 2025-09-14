import 'package:flutter/material.dart';

import '../../../../../../entities/person.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../customExpansionTile.dart';
import '../../../listViews/list_view_travel_participants.dart';
import '../../container_customContainer.dart';

class TravelParticipantsViewContainer extends StatelessWidget {
  const TravelParticipantsViewContainer({super.key, required this.memberList});

  final List<Person> memberList;

  @override
  Widget build(BuildContext context) {
    return Customexpansiontile2(
        title: "Participantes",
        widget: TravelParticipantsListView(membersList: memberList),
        initiallyExpanded: true);
  }
}

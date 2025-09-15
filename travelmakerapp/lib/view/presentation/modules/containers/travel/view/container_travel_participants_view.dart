import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../../customExpansionTile.dart';
import '../../../listViews/list_view_travel_participants.dart';


/// this widget show the participants of a travel
class TravelParticipantsViewContainer extends StatelessWidget {
  ///
  const TravelParticipantsViewContainer({super.key});


  @override
  Widget build(BuildContext context) {
    final tvp = Provider.of<TravelViewProvider>(context);

    final memberList = tvp.travel.membersList;

    return Customexpansiontile2(
        title: 'Participantes',
        widget: TravelParticipantsListView(membersList: memberList),
        initiallyExpanded: true);
  }
}

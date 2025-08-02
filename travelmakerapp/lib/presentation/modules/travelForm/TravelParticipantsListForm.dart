import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/provider/createTravelProvider.dart';

class Travelparticipantslistform extends StatelessWidget {
  const Travelparticipantslistform({super.key});

  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);


    return ListView.builder(
      itemCount: createTravelProvider.personsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Card(
            child: Row(
              children: [
                Text(createTravelProvider.personsList[index].name),
                Text(createTravelProvider.personsList[index].age.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}

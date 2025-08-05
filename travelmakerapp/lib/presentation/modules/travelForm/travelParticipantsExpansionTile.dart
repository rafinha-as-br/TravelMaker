import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/TravelParticipantsListForm.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/addParticipantDialog.dart';

class TravelParticipantsExpansionTile extends StatelessWidget {
  const TravelParticipantsExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text('teste'),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                //Participants
                SizedBox(
                  width: 200,
                  height: 150,
                  child: Travelparticipantslistform(),
                ),

                // add participants button
                Row(
                  children: [
                    Expanded(
                        child: Button1(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context) => Addparticipantdialog()
                              );
                            },
                            text: "Adicionar participante",
                            icon: Icons.add)

                    ),
                  ],
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/TravelParticipantsListForm.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/addParticipantDialog.dart';

class TravelParticipants extends StatelessWidget {
  const TravelParticipants({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(

        title: Text('teste'),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                //Participants
                Container(
                  child: Travelparticipantslistform(),
                  width: 200,
                  height: 150,
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

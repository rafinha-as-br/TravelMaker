import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/stopForm.dart';

class TravelStopExpansionTile extends StatelessWidget {
  const TravelStopExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
          title: Text('Teste'),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                // stop lists


                // add stopButton (goes and open another page)
                Row(
                  children: [
                    Expanded(
                        child: Button1(
                            onTap: (){
                              Navigator.pushNamed(context, Stopform.routeName);
                            },
                            text: "Adicionar uma nova parada",
                            icon: Icons.flag)
                    )
                  ],
                )



              ],
            ),
          ),
        ],
      ),
    );
  }
}

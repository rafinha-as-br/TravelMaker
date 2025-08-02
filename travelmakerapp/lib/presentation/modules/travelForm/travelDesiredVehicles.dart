import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/createTravelProvider.dart';

class Traveldesiredvehicles extends StatelessWidget {
  const Traveldesiredvehicles({super.key});

  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);


    return Card(
      child: ExpansionTile(
        title: Text("Veículos"),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              width: 200,
              height: 150,
              child: ListView.builder(
                  itemCount: createTravelProvider.vehicles.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Row(
                        children: [
                          Text(createTravelProvider.vehicles[index]),
                        ],
                      ),
                    );
                  },
                ),
            ),
          )
        ],),
    );
  }
}

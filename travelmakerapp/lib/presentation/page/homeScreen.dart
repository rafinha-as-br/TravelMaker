import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {

    final entities = Provider.of<EntitiesProvider>(context);


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bom dia ${entities.user.name}!", style: TextStyle(fontSize: 50, fontFamily: 'AlumniSans', height: 0.9),),
              Text("Vamos viajar?", style: TextStyle(fontSize: 50, fontFamily: 'AlumniSans', height: 0.9),),
              Text("30/06/25", style: TextStyle(fontSize: 25, fontFamily: 'AlumniSans'),),

            ],
          ),
          SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child:
            //buttons column
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //create a travel button
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap:(){
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.add_box_outlined),
                                Text('Criar uma viagem')
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                //list travels button
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap:(){
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.view_timeline_outlined),
                                Text('Visualizar minhas viagens')
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                //configs button
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap:(){
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.settings),
                                Text('Configurações')
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                )



              ],
            )
            ,
          ),


        ],
                )
      ),
    );
  }
}

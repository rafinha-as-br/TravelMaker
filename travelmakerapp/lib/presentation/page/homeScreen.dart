import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {

    final entities = context.watch<EntitiesProvider>();


    if(entities.personsList.isEmpty){
      // first screen
      return StartScreen();

    } else{
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
          child: Column(
            children: [
              Text("Bom dia! ${entities.user.name}"),
              Text("Vamos viajar?"),
              Text("30/06/25"),
              /*

              CarouselView(itemExtent: itemExtent, children: children)

              */

              ElevatedButton(onPressed: (){
              }, child: Text("Criar uma viagem")),
              ElevatedButton(onPressed: (){}, child: Text("Visualizar minhas viagens")),
              ElevatedButton(onPressed: (){}, child: Text("Configurações")),

            ],
          ),
        ),
      );
    }
  }
}

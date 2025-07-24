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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
          Column(
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Criar uma viagem")),
              ElevatedButton(onPressed: (){}, child: Text("Visualizar minhas viagens")),
              ElevatedButton(onPressed: (){}, child: Text("Configurações")),
            ],
          )


        ],
                )
      ),
    );
  }
}

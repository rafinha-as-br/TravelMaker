import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<EntitiesProvider>(context);

    if(state.personsList.isEmpty){
      // first screen
      return StartScreen();

    } else{
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
          child: Column(
            children: [
              Text("Bom dia! ${state.personsList[0].name}"),
              Text("Vamos viajar?"),
              Text("30/06/25"),
              /*

              CarouselView(itemExtent: itemExtent, children: children)

              */

              ElevatedButton(onPressed: (){}, child: Text("")),
              ElevatedButton(onPressed: (){}, child: Text("")),
              ElevatedButton(onPressed: (){}, child: Text("")),

            ],
          ),
        ),
      );
    }
  }
}

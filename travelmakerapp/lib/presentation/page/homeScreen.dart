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

    }
  }
}

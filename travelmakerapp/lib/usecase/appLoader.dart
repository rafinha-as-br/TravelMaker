import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/page/homeScreen.dart';
import '../presentation/page/startScreen.dart';
import '../presentation/provider/entitiesProvider.dart';

class Apploader extends StatelessWidget {
  const Apploader({super.key});

  static const routeName = '/appLoader';


  @override
  Widget build(BuildContext context) {
    final entities = Provider.of<EntitiesProvider>(context);

    if (entities.user.ative == false) {
      return StartScreen();
    } else {
      return HomeScreen();

    }

  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/provider/userProvider.dart';

import '../presentation/page/homeScreen.dart';
import '../presentation/page/startScreen.dart';

class Apploader extends StatelessWidget {
  const Apploader({super.key});

  static const routeName = '/appLoader';


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    if (user.user.ative == false) {
      return StartScreen();
    } else {
      return HomeScreen();

    }

  }
}

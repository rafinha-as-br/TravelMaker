import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/provider/userProvider.dart';

import '../presentation/page/homeScreen.dart';
import '../presentation/page/startScreen.dart';

class Apploader extends StatelessWidget {
  const Apploader({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!userProvider.isUserActive) {
      return StartScreen();
    }

    return HomeScreen();
  }
}


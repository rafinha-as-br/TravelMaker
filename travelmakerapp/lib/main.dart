import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/createTravelScreen.dart';
import 'package:travelmakerapp/presentation/homeScreen.dart';
import 'package:travelmakerapp/presentation/startScreen.dart';
import 'package:travelmakerapp/presentation/stopScreen.dart';
import 'package:travelmakerapp/presentation/travelsScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ),
        Provider(create: () => ),
      ]
    )
  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateTravelScreen.routeName: (context) => CreateTravelScreen(),
        StopScreen.routeName: (context) => StopScreen(),
        TravelScreens.routeName: (context) => TravelScreens(),

      },
    );
  }
}

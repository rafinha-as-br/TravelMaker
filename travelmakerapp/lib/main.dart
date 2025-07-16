import 'package:flutter/material.dart';
import 'package:travelmakerapp/UI/createTravelScreen/createTravelScreen.dart';
import 'package:travelmakerapp/UI/homeScreen/homeProvider.dart';
import 'package:travelmakerapp/UI/homeScreen/homeScreen.dart';
import 'package:travelmakerapp/UI/homeScreen/startScreen.dart';
import 'package:travelmakerapp/UI/stopScreen/stopScreen.dart';
import 'package:travelmakerapp/UI/travelsScreen/travelsScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider(), child: myApp()),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          child: StartScreen(),
        ),
      ],
    ),
  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartScreen.routeName,

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

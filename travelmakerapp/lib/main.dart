import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/page/createTravelScreen.dart';
import 'package:travelmakerapp/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/page/stopScreen.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';
import 'package:travelmakerapp/usecase/appLoader.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> EntitiesProvider())
      ],
      child: myApp(),
    )


  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'AlumniSans',
      ),
      debugShowCheckedModeBanner: false,
      home: Apploader(),

      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateTravelScreen.routeName: (context) => CreateTravelScreen(),
        StopScreen.routeName: (context) => StopScreen(),
      },
    );
  }
}

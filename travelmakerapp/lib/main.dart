import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/page/createTravelScreen.dart';
import 'package:travelmakerapp/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/page/stopScreen.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';
import 'package:travelmakerapp/presentation/provider/userProvider.dart';
import 'package:travelmakerapp/usecase/appLoader.dart';
import 'package:travelmakerapp/usecase/appThemes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final userProvider = UserProvider();
  await userProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> EntitiesProvider()),
        ChangeNotifierProvider<UserProvider>.value(value: userProvider)
      ],
      child: myApp(),
    )


  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: userProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
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

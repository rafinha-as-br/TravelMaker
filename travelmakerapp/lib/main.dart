import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/createTravelProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/entitiesProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/personProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/userProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import 'package:travelmakerapp/interface_adapters/repositories/sharedPreferencesInstance.dart';
import 'package:travelmakerapp/interface_adapters/repositories/sharedPreferencesUserRepository.dart';
import 'package:travelmakerapp/view/presentation/helpers/appLoader.dart';
import 'package:travelmakerapp/view/presentation/modules/travelForm/travelForm.dart';
import 'package:travelmakerapp/view/presentation/page/createTravelScreen.dart';
import 'package:travelmakerapp/view/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';
import 'package:travelmakerapp/view/presentation/page/stopScreen.dart';
import 'package:travelmakerapp/view/presentation/page/tests.dart';
import 'package:travelmakerapp/view/presentation/page/userConfigScreen.dart';

import 'Themes/appThemes.dart';
  
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance().init();

  final userRepository = SharedPreferencesUserRepository();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> EntitiesProvider()),
        ChangeNotifierProvider(create: (_)=> UserProvider(userRepository)),
        ChangeNotifierProvider(create: (_)=> CreateTravelProvider()),
        ChangeNotifierProvider(create: (_)=> PersonProvider())

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pt'),
        Locale('es')
      ],
      locale: userProvider.user!.locale,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: userProvider.user!.darkTheme ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Apploader(),

      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateTravelScreen.routeName: (context) => CreateTravelScreen(),
        StopScreen.routeName: (context) => StopScreen(),
        UserConfigScreen.routeName : (context) => UserConfigScreen(),
        TestScreen.routeName : (context) => TestScreen(),
        TravelForm.routeName : (context) => TravelForm(),
      },
    );
  }
}

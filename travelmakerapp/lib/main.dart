import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/page/createTravelScreen.dart';
import 'package:travelmakerapp/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/page/stopScreen.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/page/tests.dart';
import 'package:travelmakerapp/presentation/page/userConfigScreen.dart';
import 'package:travelmakerapp/presentation/provider/createTravelProvider.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';
import 'package:travelmakerapp/presentation/provider/userProvider.dart';
import 'package:travelmakerapp/usecase/appLoader.dart';
import 'package:travelmakerapp/usecase/Themes/appThemes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import 'package:travelmakerapp/usecase/sharedPreferences/sharedPreferencesInstance.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> EntitiesProvider()),
        ChangeNotifierProvider(create: (_)=> UserProvider()),
        ChangeNotifierProvider(create: (_)=> CreateTravelProvider()),

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
      locale: userProvider.user.locale,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: userProvider.user.darkTheme ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Apploader(),

      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateTravelScreen.routeName: (context) => CreateTravelScreen(),
        StopScreen.routeName: (context) => StopScreen(),
        UserConfigScreen.routeName : (context) => UserConfigScreen(),
        TestScreen.routeName : (context) => TestScreen()
      },
    );
  }
}

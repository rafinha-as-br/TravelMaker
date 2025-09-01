import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/interface_adapters/controllers/appSettingsController.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/createTravelProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/entitiesProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/personProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/userProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import 'package:travelmakerapp/view/database/database.dart';
import 'package:travelmakerapp/view/presentation/helpers/appLoader.dart';
import 'package:travelmakerapp/view/presentation/modules/travelForm/travelForm.dart';
import 'package:travelmakerapp/view/presentation/page/createTravelScreen.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallEndScreen.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallScreen.dart';
import 'package:travelmakerapp/view/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/view/presentation/page/loadingScreen.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';
import 'package:travelmakerapp/view/presentation/page/stopScreen.dart';
import 'package:travelmakerapp/view/presentation/page/tests.dart';
import 'package:travelmakerapp/view/presentation/page/userConfigScreen.dart';

import 'Themes/appThemes.dart';
import 'interface_adapters/implementations/user_repository.dart';
  
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //sharedPreferences instance
  final prefs = await SharedPreferences.getInstance();

  //database instance
  final appDataBase = AppDatabase();
  final db = await appDataBase.database;

  final userRepository = UserRepositoryImpl(prefs, db);
  final settingsController = AppSettingsController(); /// the necessary configs implementations are passed to myApp


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> EntitiesProvider()),
        ChangeNotifierProvider(create: (_)=> UserProvider(userRepository)),
        ChangeNotifierProvider(create: (_)=> CreateTravelProvider()),
        ChangeNotifierProvider(create: (_)=> PersonProvider()),
        ChangeNotifierProvider(create: (_)=> AppStateProvider(userRepository))
      ],
      child: myApp(settingsController: settingsController,), // myApp receives the settings
    )


  );
}

class myApp extends StatelessWidget {
  const myApp({super.key, required this.settingsController});

  final AppSettingsController settingsController;

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<AppSettings>(
      valueListenable: settingsController.settings,
      builder: (context, settings, child) {
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
          locale: settings.locale,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: settings.themeMode,
          debugShowCheckedModeBanner: false,
          home: AppLoaderScreen(),

          routes: {
            StartScreen.routeName: (context) => StartScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            CreateTravelScreen.routeName: (context) => CreateTravelScreen(),
            StopScreen.routeName: (context) => StopScreen(),
            UserConfigScreen.routeName : (context) => UserConfigScreen(),
            TestScreen.routeName : (context) => TestScreen(),
            TravelForm.routeName : (context) => TravelForm(),
            GpsCallScreen.routeName : (context) => GpsCallScreen(),
            GpsCallEndScreen.routeName : (context) => GpsCallEndScreen(),
            LoadingScreen.routeName : (context) => LoadingScreen(),
            AppLoaderScreen.routeName : (context) => AppLoaderScreen()
          },
        );
      }
    );
  }
}

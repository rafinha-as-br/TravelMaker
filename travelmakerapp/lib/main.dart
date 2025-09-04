import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/interface_adapters/controllers/appSettingsController.dart';
import 'package:travelmakerapp/interface_adapters/implementations/location_service.dart';
import 'package:travelmakerapp/interface_adapters/implementations/settings_repository.dart';
import 'package:travelmakerapp/interface_adapters/implementations/stop_repository.dart';
import 'package:travelmakerapp/interface_adapters/implementations/travel_repository.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/createTravelProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/entitiesProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/personProvider.dart';
 import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import 'package:travelmakerapp/usecase/repositories/stop_repository.dart';
import 'package:travelmakerapp/view/database/database.dart';
import 'package:travelmakerapp/view/database/travel_stop_repository.dart';
import 'package:travelmakerapp/view/presentation/Themes/appThemes.dart';
import 'package:travelmakerapp/view/presentation/modules/travelForm/travelForm.dart';
import 'package:travelmakerapp/view/presentation/page/createTravelScreen.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallEndScreen.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallScreen.dart';
import 'package:travelmakerapp/view/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/view/presentation/page/loading_screen.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';
import 'package:travelmakerapp/view/presentation/page/stopScreen.dart';
import 'package:travelmakerapp/view/presentation/page/travel_list_screen.dart';
import 'package:travelmakerapp/view/presentation/page/user_config_screen.dart';

import 'entities/appSettings.dart';
import 'interface_adapters/implementations/user_repository.dart';
  
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //sharedPreferences instance
  final prefs = await SharedPreferences.getInstance();

  //database instance
  final appDataBase = AppDatabase();
  final db = await appDataBase.database;

  final userRepository = UserRepositoryImpl(prefs, db);
  final settingsRepository = SettingsRepositoryImpl(prefs);
  final settingsController = AppSettingsController(settingsRepository); /// the necessary configs implementations are passed to myApp
  final locationService = LocationServiceImpl();
  final travelRepository = TravelRepositoryImpl(db);
  final stopRepository = StopRepositoryImpl(db);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> EntitiesProvider()),
        ChangeNotifierProvider(create: (_)=> CreateTravelProvider(userRepository)),
        ChangeNotifierProvider(create: (_)=> PersonProvider()),
        ChangeNotifierProvider(create: (_)=> AppStateProvider(userRepository, db, locationService))
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
          home: AppLoaderScreen(settingsController: settingsController,),

          routes: {
            StartScreen.routeName: (context) => StartScreen(settingsController: settingsController,),
            HomeScreen.routeName: (context) => HomeScreen(),
            CreateTravelScreen.routeName: (context) => CreateTravelScreen(),
            StopScreen.routeName: (context) => StopScreen(),
            UserConfigScreen.routeName : (context) => UserConfigScreen(settingsController: settingsController,),
            TravelForm.routeName : (context) => TravelForm(),
            GpsCallScreen.routeName : (context) => GpsCallScreen(),
            GpsCallEndScreen.routeName : (context) => GpsCallEndScreen(),
            AppLoaderScreen.routeName : (context) => AppLoaderScreen(settingsController: settingsController,),
            TravelListScreen.routeName : (context) => TravelListScreen()
          },
        );
      }
    );
  }
}

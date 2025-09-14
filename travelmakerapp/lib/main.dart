import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmakerapp/interface_adapters/controllers/appSettingsController.dart';
import 'package:travelmakerapp/interface_adapters/implementations/implementation_location_service.dart';
import 'package:travelmakerapp/interface_adapters/implementations/implementation_person_repository.dart';
import 'package:travelmakerapp/interface_adapters/implementations/implementation_settings_repository.dart';
import 'package:travelmakerapp/interface_adapters/implementations/implementation_stop_repository.dart';
import 'package:travelmakerapp/interface_adapters/implementations/implementation_travel_repository.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/provider_create_travel.dart';
import 'package:travelmakerapp/interface_adapters/providers/personProvider.dart';
 import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import 'package:travelmakerapp/usecase/repositories/repository_person.dart';
import 'package:travelmakerapp/usecase/repositories/repository_travel_stop.dart';
import 'package:travelmakerapp/usecase/repositories/repository_travel.dart';
import 'package:travelmakerapp/usecase/repositories/repository_user.dart';
import 'package:travelmakerapp/view/database/database.dart';
import 'package:travelmakerapp/view/presentation/Themes/appThemes.dart';
import 'package:travelmakerapp/view/presentation/modules/travelForm/travelForm.dart';
import 'package:travelmakerapp/view/presentation/page/screen_create_travel.dart';
import 'package:travelmakerapp/view/presentation/page/screen_gps_call_end.dart';
import 'package:travelmakerapp/view/presentation/page/screen_gps_call.dart';
import 'package:travelmakerapp/view/presentation/page/screen_home_screen.dart';
import 'package:travelmakerapp/view/presentation/page/loading_screen.dart';
import 'package:travelmakerapp/view/presentation/page/screen_start_screen.dart';
import 'package:travelmakerapp/view/presentation/page/screen_create_stop.dart';
import 'package:travelmakerapp/view/presentation/page/screen_travel_list.dart';
import 'package:travelmakerapp/view/presentation/page/screen_travel_view.dart';
import 'package:travelmakerapp/view/presentation/page/screen_user_config.dart';

import 'entities/appSettings.dart';
import 'interface_adapters/implementations/implementation_comment_repository.dart';
import 'interface_adapters/implementations/implementation_user_repository.dart';
  
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
  final personRepository = PersonRepositoryImpl(db);
  final commentRepo = CommentRepositoryImpl(db);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> PersonProvider()),
        ChangeNotifierProvider(create: (_)=> AppStateProvider(
          userRepository, db, locationService, travelRepository,
          stopRepository, personRepository, commentRepo
        )),
        Provider<UserRepository>.value(value: userRepository),
        Provider<TravelRepository>.value(value: travelRepository),
        Provider<StopRepository>.value(value: stopRepository),
        Provider<PersonRepository>.value(value: personRepository),
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
            UserConfigScreen.routeName : (context) => UserConfigScreen(settingsController: settingsController,),
            TravelForm.routeName : (context) => TravelForm(),
            GpsCallScreen.routeName : (context) => GpsCallScreen(),
            GpsCallEndScreen.routeName : (context) => GpsCallEndScreen(),
            AppLoaderScreen.routeName : (context) => AppLoaderScreen(settingsController: settingsController,),
            TravelListScreen.routeName : (context) => TravelListScreen(),
          },
        );
      }
    );
  }
}

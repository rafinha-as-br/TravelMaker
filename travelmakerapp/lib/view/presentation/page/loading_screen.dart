import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/page/screen_create_travel.dart';
import 'package:travelmakerapp/view/presentation/page/screen_gps_call_end.dart';
import 'package:travelmakerapp/view/presentation/page/screen_gps_call.dart';
import 'package:travelmakerapp/view/presentation/modules/customLoadingWidget.dart';
import 'package:travelmakerapp/view/presentation/page/screen_start_screen.dart';

import '../../../entities/app_state.dart';
import '../../../interface_adapters/controllers/controller_app_settings.dart';
import 'screen_home_screen.dart';

// this screen is the main screen that redirects to the principals screens
class AppLoaderScreen extends StatelessWidget {
  const AppLoaderScreen({super.key, required this.settingsController});

  final AppSettingsController settingsController;

  static const routeName = '/appLoaderScreen';


  @override
  Widget build(BuildContext context) {
    final asp = Provider.of<AppStateProvider>(context, listen: false);


    return FutureBuilder<Validator>(
      future: Future.wait([
        asp.initializeApp(),
        settingsController.initializeSettings()
      ]).then((results) => results.first),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CustomLoadingWidget();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final appStatus = snapshot.data!;
            switch (asp.appStatus) {

              case AppStatus.needGPS:
                   
                if (appStatus.message == 'LocationPermissionDenied') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(context, GpsCallScreen.routeName);
                  });
                }
                if (appStatus.message == 'LocationPermissionDeniedForever') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(context, GpsCallEndScreen.routeName);
                  });
                }
                break;
              case AppStatus.userNotActive:
                   
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, StartScreen.routeName,
                      arguments: settingsController);
                });
                break;

              case AppStatus.ready:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                });
                break;

              case AppStatus.editingTravel:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, CreateTravelScreen.routeName);
                });
                break;

              case AppStatus.creatingTravel:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, CreateTravelScreen.routeName);
                });
                break;

              default:
                return CustomLoadingWidget();
            }

        }
        return CustomLoadingWidget();
      },
    );
  }
}


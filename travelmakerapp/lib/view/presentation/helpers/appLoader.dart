import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallEndScreen.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallScreen.dart';
import 'package:travelmakerapp/view/presentation/page/loadingScreen.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';

import '../../../entities/appState.dart';
import '../page/homeScreen.dart';

class AppLoaderScreen extends StatelessWidget {
  const AppLoaderScreen({super.key});

  static const routeName = '/appLoaderScreen';


  @override
  Widget build(BuildContext context) {
    final asp = Provider.of<AppStateProvider>(context, listen: false);

    return FutureBuilder<Validator>(
      future: asp.initializeApp(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingScreen();
        }

        final appStatus = snapshot.data!;
        if (!appStatus.success) {
          switch (asp.appStatus) {
            case AppStatus.needGPS:
              if (appStatus.message == 'LocationPermissionDenied') {
                return GpsCallScreen();
              }
              if (appStatus.message == 'LocationPermissionDeniedForever') {
                return GpsCallEndScreen();
              }
              break;
            case AppStatus.userNotActive:
              //cheking in the dataBase


              return StartScreen();
            case AppStatus.initializing:
              print("App status: ${asp.appStatus}");

              return LoadingScreen();
            case AppStatus.ready:
              // if app status is ready, then applicates the app themes from
              // provider


              return HomeScreen();
            case AppStatus.errorDatabase:
              print("App status: ${asp.appStatus}");

              return LoadingScreen();
          }
        }
        print("App status: ${asp.appStatus}");

        return HomeScreen();
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallEndScreen.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallScreen.dart';
import 'package:travelmakerapp/view/presentation/page/loadingScreen.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';

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
            case AppStatus.needUser:
              return StartScreen();
            case AppStatus.initializing:
              return LoadingScreen();
            case AppStatus.ready:
              return HomeScreen();
          }
        }

        return HomeScreen();
      },
    );
  }
}


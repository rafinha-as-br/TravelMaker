import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallEndScreen.dart';
import 'package:travelmakerapp/view/presentation/page/gpsCallScreen.dart';
import 'package:travelmakerapp/view/presentation/modules/customLoadingWidget.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';

import '../../../entities/appState.dart';
import '../../../interface_adapters/controllers/appSettingsController.dart';
import 'homeScreen.dart';

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
          return CustomLoadingWidget(   );
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
              default:
                return CustomLoadingWidget(   );
            }

        }
        return CustomLoadingWidget(   );
      },
    );
  }
}


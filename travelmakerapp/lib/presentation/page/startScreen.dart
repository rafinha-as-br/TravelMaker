import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/startScreen_title.dart';
import 'package:travelmakerapp/presentation/modules/buttons/toggleThemeButton.dart';
import 'package:travelmakerapp/presentation/modules/userForm.dart';
import 'package:travelmakerapp/usecase/location/getDeviceLocation.dart';


import '../modules/buttons/toggleLanguageButton.dart';
import '../provider/userProvider.dart';

class StartScreen extends StatelessWidget {

  static const routeName = '/StartScreen';

  StartScreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 37),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TogglelanguagebuttonReduced(),
                SizedBox(width: 10,),
                TogglethemebuttonReduced(),
              ],
            ),
            StartscreenTitle(),
            UserForm()
          ],
        ),
      ),
    );
  }
}

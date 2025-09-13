import 'package:flutter/material.dart';
import '../../../interface_adapters/controllers/appSettingsController.dart';
import '../modules/buttons/toggleLanguageButton.dart';
import '../modules/buttons/toggleThemeButton.dart';
import '../modules/startScreen_title.dart';
import '../modules/userForm.dart';

class StartScreen extends StatelessWidget {

  static const routeName = '/StartScreen';
  final AppSettingsController settingsController;
  
  const StartScreen({super.key, required this.settingsController});



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
                ToggleLanguageButtonReduced(settingsController: settingsController,),
                SizedBox(width: 10,),
                TogglethemebuttonReduced(appSettingsController: settingsController,),
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

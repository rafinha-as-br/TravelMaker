import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/startScreen_title.dart';
import 'package:travelmakerapp/presentation/modules/toggleThemeButton.dart';
import 'package:travelmakerapp/presentation/modules/userForm.dart';


import '../modules/toggleLanguageButton.dart';

class StartScreen extends StatelessWidget {

  static const routeName = '/StartScreen';

  StartScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Togglelanguagebutton(),
                Togglethemebutton(),
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

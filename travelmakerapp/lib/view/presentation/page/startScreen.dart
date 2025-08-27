import 'package:flutter/material.dart';
import '../modules/buttons/toggleLanguageButton.dart';
import '../modules/buttons/toggleThemeButton.dart';
import '../modules/startScreen_title.dart';
import '../modules/userForm.dart';

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

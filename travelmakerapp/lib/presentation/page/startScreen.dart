import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/presentation/modules/startScreen_title.dart';
import 'package:travelmakerapp/presentation/modules/toggleThemeButton.dart';
import 'package:travelmakerapp/presentation/modules/userForm.dart';
import 'package:travelmakerapp/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';

import '../modules/toggleLanguageButton.dart';

class StartScreen extends StatelessWidget {

  static const routeName = '/StartScreen';

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();


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

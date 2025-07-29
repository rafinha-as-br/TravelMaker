import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/toggleLanguageButton.dart';
import 'package:travelmakerapp/presentation/modules/toggleThemeButton.dart';

import '../../usecase/appThemes.dart';
import '../provider/userProvider.dart';

class UserConfigScreen extends StatelessWidget {
  const UserConfigScreen({super.key});

  static const routeName = '/UserConfigScreen';


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: userProvider.darkTheme ?  AppThemes.darkTheme.primaryColor : AppThemes.lightTheme.primaryColor),
        backgroundColor: userProvider.darkTheme ? AppThemes.darkTheme.canvasColor : AppThemes.lightTheme.canvasColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child:Togglethemebutton(),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Togglelanguagebutton(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/buttons/button1.dart';
import 'package:travelmakerapp/presentation/modules/buttons/toggleLanguageButton.dart';
import 'package:travelmakerapp/presentation/modules/buttons/toggleThemeButton.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

import '../../usecase/Themes/appThemes.dart';
import '../provider/userProvider.dart';

class UserConfigScreen extends StatelessWidget {
  const UserConfigScreen({super.key});

  static const routeName = '/UserConfigScreen';


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: getPrimaryColor()),
        backgroundColor: getCanvasColor(),
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
                  child:TogglethemebuttonExpanded(),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TogglelanguagebuttonExpanded(),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Button1(
                      onTap: (){
                        userProvider.removeUser();
                        Navigator.pushNamed(context, StartScreen.routeName);
                  }, text: 'Excluir usuário',
                      icon: Icons.delete_forever),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

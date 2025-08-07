import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/buttons/toggleLanguageButton.dart';
import 'package:travelmakerapp/presentation/modules/buttons/toggleThemeButton.dart';
import 'package:travelmakerapp/presentation/modules/userDialog.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';
import '../../l10n/app_localizations.dart';
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
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Column()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // edit user data button
            Row(
              children: [
                Expanded(
                    child: SmallButton1(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) => userDialog()
                          );
                        },
                        text: 'Push dialog',
                        icon: Icons.edit))
              ],
            ),
            
            //change theme button
            Row(
              children: [
                Expanded(
                  child:TogglethemebuttonExpanded(),
                )
              ],
            ),
            
            // change language button
            Row(
              children: [
                Expanded(
                  child: TogglelanguagebuttonExpanded(),
                )
              ],
            ),
            
            // delete user button
            Row(
              children: [
                Expanded(
                  child: SmallButton1(
                      onTap: (){
                        userProvider.removeUser();
                        Navigator.pushNamed(context, StartScreen.routeName);
                  }, text: AppLocalizations.of(context)!.deleteUser,
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

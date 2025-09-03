import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';
import '../../../interface_adapters/controllers/appSettingsController.dart';
import '../../../interface_adapters/providers/AppStateProvider.dart';
import '../../../l10n/app_localizations.dart';
import '../modules/buttons/customButton.dart';
import '../modules/buttons/toggleLanguageButton.dart';
import '../modules/buttons/toggleThemeButton.dart';
import '../modules/userDialog.dart';

class UserConfigScreen extends StatelessWidget {
  const UserConfigScreen({super.key,
    required this.settingsController,
  });

  final AppSettingsController settingsController;

  static const routeName = '/UserConfigScreen';


  @override
  Widget build(BuildContext context) {
    final aps = Provider.of<AppStateProvider>(context);


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).canvasColor,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Column(
              children: [

              ],
            )
        ),
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
                  child:TogglethemebuttonExpanded(settingsController: settingsController,),
                )
              ],
            ),
            
            // change language button
            Row(
              children: [
                Expanded(
                  child: ToggleLanguageButtonExpanded(settingsController: settingsController,),
                )
              ],
            ),
            
            // delete user button
            Row(
              children: [
                Expanded(
                  child: SmallButton1(
                      onTap: () async{
                        final removeUser = await aps.removeUser();
                        if(!removeUser.success && context.mounted){
                          showDialog(
                              context: context,
                              builder: (context) => ErrorDialog(textError: removeUser.message!)
                          );
                        }
                        if(context.mounted) { // just to remove the context problem with async
                          Navigator.pushNamed(context, StartScreen.routeName);
                        }
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

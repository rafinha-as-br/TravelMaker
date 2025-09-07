import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/customLoadingWidget.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/view/presentation/page/startScreen.dart';
import '../../../interface_adapters/controllers/appSettingsController.dart';
import '../../../interface_adapters/providers/AppStateProvider.dart';
import '../../../l10n/app_localizations.dart';
import '../modules/buttons/customButton.dart';
import '../modules/buttons/toggleLanguageButton.dart';
import '../modules/buttons/toggleThemeButton.dart';
import '../modules/dialogs/userDialog.dart';

class UserConfigScreen extends StatelessWidget {
  const UserConfigScreen({super.key,
    required this.settingsController,
  });

  final AppSettingsController settingsController;

  static const routeName = '/UserConfigScreen';


  @override
  Widget build(BuildContext context) {
    final asp = Provider.of<AppStateProvider>(context);


    return FutureBuilder(
      future: asp.getUser(),
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return CustomLoadingWidget();
        }
        if(asyncSnapshot.connectionState == ConnectionState.done){
          final user = asyncSnapshot.data;
          if(user!= null){
            return Scaffold(

              //user data app bar
              appBar: AppBar(
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                backgroundColor: Theme.of(context).canvasColor,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(140),
                    child: Column(
                      spacing: 15,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: user.profilePicturePath == null
                              ? null
                              : FileImage(
                            File(user.profilePicturePath!),
                          ),
                          child: user.profilePicturePath == null
                              ? Icon(
                            Icons.person,
                            size: 45,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          )
                              : null,
                        ),
                        Text(
                          "${user.name}, ${user.age} anos",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(
                          height: 5,
                        )

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
                                onTap: () async{
                                  await asp.setControllers(user);

                                  if(context.mounted){
                                    showDialog(
                                        context: context,
                                        builder: (context) => UserDialog(user: user ,)
                                    );
                                  }

                                },
                                text: 'Edit user',
                                icon: Icons.edit))
                      ],
                    ),

                    //change theme button
                    Row(
                      children: [
                        Expanded(
                          child:ToggleThemeButtonExpanded(settingsController: settingsController,),
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
                                final removeUser = await asp.removeUser();
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
        return CustomLoadingWidget();

      }
    );
  }
}

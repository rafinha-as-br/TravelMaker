import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/customLoadingWidget.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/view/presentation/page/screen_start_screen.dart';
import '../../../interface_adapters/controllers/appSettingsController.dart';
import '../../../interface_adapters/providers/AppStateProvider.dart';
import '../../../l10n/app_localizations.dart';
import '../modules/buttons/customButton.dart';
import '../modules/buttons/toggleLanguageButton.dart';
import '../modules/buttons/toggleThemeButton.dart';
import '../modules/circleAvatars/circle_avatar_user.dart';
import '../modules/dialogs/userDialog.dart';

class UserConfigScreen extends StatefulWidget {
  const UserConfigScreen({super.key,
    required this.settingsController,
  });

  final AppSettingsController settingsController;

  static const routeName = '/UserConfigScreen';

  @override
  State<UserConfigScreen> createState() => _UserConfigScreenState();
}

class _UserConfigScreenState extends State<UserConfigScreen> {
  late final AppStateProvider asp;
  dynamic _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    asp = Provider.of<AppStateProvider>(context, listen: false);

    loadUser();
    super.initState();
  }

  Future<void> loadUser() async{
    final user = await asp.getUser();
    if(mounted){
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CustomLoadingWidget();
    }

    if (_user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Nenhum usuário encontrado",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      );
    }

    final user = _user!;

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
                UserCircleAvatar(user: user),
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
                            await showDialog(
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
                  child:ToggleThemeButtonExpanded(settingsController: widget.settingsController,),
                )
              ],
            ),

            // change language button
            Row(
              children: [
                Expanded(
                  child: ToggleLanguageButtonExpanded(settingsController: widget.settingsController,),
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
                          await showDialog(
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

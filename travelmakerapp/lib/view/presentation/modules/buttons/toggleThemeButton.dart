import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 import 'package:travelmakerapp/view/presentation/modules/dialogs/errorDialog.dart';
 import '../../../../interface_adapters/controllers/appSettingsController.dart';
import '../../../../l10n/app_localizations.dart';



// toggleThemeButton expanded (with icon and text), used in userConfigScreen
class TogglethemebuttonExpanded extends StatelessWidget {
  final AppSettingsController settingsController;

  const TogglethemebuttonExpanded({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async{
        final toggleTheme = await settingsController.toggleTheme();
        if(!toggleTheme.success  && context.mounted){
          showDialog(
              context: context,
              builder: (context) => ErrorDialog(textError: toggleTheme.message!)
          );
        }
      },
      borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          width: 140,
          height: 40,
          decoration: BoxDecoration(
            color:  Theme.of(context).canvasColor,
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(Theme.of(context).brightness == Brightness.dark?
                    Icons.dark_mode_outlined
                    : Icons.light_mode_outlined
                  , color: Theme.of(context).primaryColor,),
                Text(
                    Theme.of(context).brightness == Brightness.dark?
                    AppLocalizations.of(context)!.darkTheme
                    : AppLocalizations.of(context)!.lightTheme,
                    style: Theme.of(context).textTheme.displaySmall),
              ],)
        )
    );
  }
}

// toggleThemeButton expanded (only with icon), used in startScreen
class TogglethemebuttonReduced extends StatelessWidget {
  final AppSettingsController appSettingsController;

  const TogglethemebuttonReduced({super.key, required this.appSettingsController});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async{
        final toggleTheme = await appSettingsController.toggleTheme();
        if(!toggleTheme.success  && context.mounted){
          showDialog(
              context: context,
              builder: (context) => ErrorDialog(textError: toggleTheme.message!)
          );
        }
      },
      borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color:  Theme.of(context).canvasColor,
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(
                  Theme.of(context).brightness == Brightness.dark?
                    Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 10,),

              ],)
        )
    );
  }
}

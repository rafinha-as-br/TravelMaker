import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/userProvider.dart';
import '../../../../Themes/getTheme.dart';
import '../../../../l10n/app_localizations.dart';



// toggleThemeButton expanded (with icon and text), used in userConfigScreen
class TogglethemebuttonExpanded extends StatelessWidget {
  const TogglethemebuttonExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){
        userProvider.changeTheme(!getActiveTheme());
      },
      borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          width: 140,
          height: 40,
          decoration: BoxDecoration(
            color: getCanvasColor(),
            border: Border.all(
              width: 1.5,
              color: getPrimaryColor(),
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(getIconTheme(), color: getPrimaryColor(),),
                Text(
                    getActiveTheme() ? AppLocalizations.of(context)!.darkTheme : AppLocalizations.of(context)!.lightTheme,
                    style: Theme.of(context).textTheme.displaySmall),
              ],)
        )
    );
  }
}

// toggleThemeButton expanded (only with icon), used in startScreen
class TogglethemebuttonReduced extends StatelessWidget {
  const TogglethemebuttonReduced({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){
        userProvider.changeTheme(!getActiveTheme());
      },
      borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: getCanvasColor(),
            border: Border.all(
              width: 1.5,
              color: getPrimaryColor(),
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(getIconTheme(), color: getPrimaryColor(),),
                SizedBox(width: 10,),

              ],)
        )
    );
  }
}

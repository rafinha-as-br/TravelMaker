import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';

import '../../../../Themes/getTheme.dart';
import '../../../../interface_adapters/providers/userProvider.dart';

// expanded toggleLanguageButton, (with text and flag), used in userConfigScreen
class TogglelanguagebuttonExpanded extends StatelessWidget {
  const TogglelanguagebuttonExpanded({super.key});


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){
        userProvider.changeLanguage();

      },
      child: Container(
        width: 180,
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
          children: [
            userProvider.countryFlag,
            SizedBox(width: 10,),
            Text(AppLocalizations.of(context)!.changeLanguage, style: Theme.of(context).textTheme.displaySmall,),
          ],
        ),
      ),
    );
  }
}

// reduced toggleLanguageButton (only with flag), used in startScreen
class TogglelanguagebuttonReduced extends StatelessWidget {
  const TogglelanguagebuttonReduced({super.key});


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){
        userProvider.changeLanguage();
      },
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
        child: userProvider.countryFlag,
      ),
    );
  }
}

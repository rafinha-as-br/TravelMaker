import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';
import '../../usecase/Themes/appThemes.dart';
import '../provider/userProvider.dart';

class Togglelanguagebutton extends StatelessWidget {
  const Togglelanguagebutton({super.key});


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
            SizedBox(width: 20,),
            userProvider.countryFlag,
            SizedBox(width: 10,),
            Text(AppLocalizations.of(context)!.changeLanguage, style: Theme.of(context).textTheme.displaySmall,),
          ],
        ),
      ),
    );
  }
}

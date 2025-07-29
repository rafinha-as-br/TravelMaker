import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import '../../usecase/appThemes.dart';
import '../provider/userProvider.dart';

class Togglelanguagebutton extends StatelessWidget {
  const Togglelanguagebutton({super.key});


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){
        userProvider.setLanguage();

      },
      child: Container(
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color: userProvider.darkTheme ? AppThemes.darkTheme.canvasColor : AppThemes.lightTheme.canvasColor,
          border: Border.all(
            width: 1.5,
            color: userProvider.darkTheme ? Color(0xFFF9F3EF): Color(0xFF3A6B8A),
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          spacing: 20,
          children: [
            SizedBox(width: 10,),
            userProvider.countryFlag,
            Text(AppLocalizations.of(context)!.changeLanguage, style: Theme.of(context).textTheme.displaySmall,),
          ],
        ),
      ),
    );
  }
}

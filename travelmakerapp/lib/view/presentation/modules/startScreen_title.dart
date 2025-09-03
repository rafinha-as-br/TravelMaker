import 'package:flutter/material.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';

class StartscreenTitle extends StatelessWidget {
  const StartscreenTitle({super.key});

  @override
  Widget build(BuildContext context) {

    final Image logoIcon;
    final Image logoText;

    if(Theme.of(context).brightness == Brightness.dark){
      logoIcon = Image.asset('assets/images/cello_trips_logo_icon_dark_theme.jpg', width: 300, height: 150,);
      logoText = Image.asset('assets/images/cello_trips_logo_text_dark_theme.jpg', width: 300,);
    } else{
      logoIcon = Image.asset('assets/images/cello_trips_logo_icon_light_theme.jpg', width: 300, height: 150, );
      logoText = Image.asset('assets/images/cello_trips_logo_text_light_theme.jpg', width: 300, );
    }


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.welcome, style: Theme.of(context).textTheme.displayLarge,)
            ],
          ),
          SizedBox(
            height: 230,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: logoIcon,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: logoText,
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.beforeStart, style: Theme.of(context).textTheme.displayMedium)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.informNameAge, style: Theme.of(context).textTheme.displayMedium)
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';

class StartscreenTitle extends StatelessWidget {
  const StartscreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.welcome, style: Theme.of(context).textTheme.displayLarge,)
            ],
          ),
          Image.asset('assets/images/Logo1.png', width: 300, height: 150,),
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

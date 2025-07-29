import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../provider/userProvider.dart';

class HomeScreenTitle extends StatelessWidget {
  const HomeScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${user.getGreeting(user.dateToday, context)} ${user.user.name}', style: Theme.of(context).textTheme.displayLarge),
        Text(AppLocalizations.of(context)!.letsGoTravel, style: Theme.of(context).textTheme.displayLarge),
        Text(user.getDate(), style: Theme.of(context).textTheme.displayMedium)
      ],
    );
  }
}

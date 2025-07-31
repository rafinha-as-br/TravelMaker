import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/usecase/dates/dateFormat.dart';

import '../../l10n/app_localizations.dart';
import '../provider/userProvider.dart';

class HomeScreenTitle extends StatelessWidget {
  const HomeScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${getGreeting(context)} ${userProvider.user.name}', style: Theme.of(context).textTheme.displayLarge),
        Text(AppLocalizations.of(context)!.letsGoTravel, style: Theme.of(context).textTheme.displayLarge),
        Text(getFormatedDate1(), style: Theme.of(context).textTheme.displayMedium)
      ],
    );
  }
}

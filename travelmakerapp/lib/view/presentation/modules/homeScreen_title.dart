import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/usecase/repositories/user_repository.dart';

import '../../../entities/user.dart';
import '../../../l10n/app_localizations.dart';
import '../helpers/dates/dateFormat.dart';
class HomeScreenTitle extends StatelessWidget {
  final User user;
  const HomeScreenTitle({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${getGreeting(context)} ${user.name}', style: Theme.of(context).textTheme.displayLarge),
        Text(AppLocalizations.of(context)!.letsGoTravel, style: Theme.of(context).textTheme.displayLarge),
        Text(getFormatedDate1(), style: Theme.of(context).textTheme.displayMedium)
      ],
    );
  }
}

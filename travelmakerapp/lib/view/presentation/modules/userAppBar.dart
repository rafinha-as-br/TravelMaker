import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Themes/getTheme.dart';
import '../../../interface_adapters/providers/userProvider.dart';
import '../../../l10n/app_localizations.dart';

class userAppBar extends StatelessWidget {
  const userAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return AppBar(
      iconTheme: IconThemeData(color: getPrimaryColor()),
      backgroundColor: getCanvasColor(),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: Column(
            children: [
              // image
              Text(''
                  '${user!.name}, '
                  '${user.age} '
                  '${AppLocalizations.of(context)!.years}'
              )
            ],
          )
      ),
    );
  }
}

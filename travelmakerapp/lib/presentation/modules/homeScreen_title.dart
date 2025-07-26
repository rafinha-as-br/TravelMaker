import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userProvider.dart';

class HomeScreenTitle extends StatelessWidget {
  const HomeScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bom dia! ${user.user.name}', style: Theme.of(context).textTheme.displayLarge),
        Text('Vamos viajar?', style: Theme.of(context).textTheme.displayLarge),
        Text('30/06/25', style: Theme.of(context).textTheme.displayMedium)
      ],
    );
  }
}

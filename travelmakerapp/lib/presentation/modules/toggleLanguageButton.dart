import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import '../provider/userProvider.dart';

class Togglelanguagebutton extends StatelessWidget {
  const Togglelanguagebutton({super.key});


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){
        userProvider.setLanguage('en');
      },
      child: Container(
        child: Row(
          children: [
            Text('Trocar idioma'),
          ],
        ),
      ),
    );
  }
}

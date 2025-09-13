import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../page/loading_screen.dart';
import '../dialogs/errorDialog.dart';
import 'customButton.dart';

class CreateTravelButton extends StatelessWidget {
  const CreateTravelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return Row(
      children: [
        Expanded(
          child: MediumButton2(
              onTap: () async{
                final createTravel = await ctp.createTravel();
                if(!createTravel.success && context.mounted){
                  showDialog(
                      context: context,
                      builder: (context) => ErrorDialog(textError: createTravel.message!)
                  );
                } else if(context.mounted){
                  // cleaning the controllers (don't need anymore because it already closes it!)
                  ctp.clearTravelData();

                  // need to update the AppState enum to ready!


                  //sending to the home page
                  Navigator.pushNamed(context, AppLoaderScreen.routeName);

                }

              },
              text: AppLocalizations.of(context)!.createTravelButton,
              icon: Icons.airplane_ticket_outlined
          ),
        ),
      ],
    );
  }
}

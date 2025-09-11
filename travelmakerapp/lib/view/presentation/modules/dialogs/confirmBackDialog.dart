import 'package:flutter/material.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';

import '../buttons/customButton.dart';
import 'customDialog.dart';

class ConfirmbackDialog extends StatelessWidget {
  const ConfirmbackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog2(
        title: "Espere aí!",
        icon: Icons.sd_card_alert_outlined,
        widget: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Deseja sair? Você perderá todas as alterações!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallButton1(
                    onTap: (){
                      Navigator.of(context).pop(false);
                    },
                    text: "Cancelar",
                    icon: Icons.cancel_outlined
                ),

                //confirm buton
                SmallButton1(
                    onTap: (){
                      Navigator.of(context).pop(true);
                    },
                    text: "Continuar",
                    icon: Icons.check),
              ],
            )
          ],
    ),
    );
  }
}

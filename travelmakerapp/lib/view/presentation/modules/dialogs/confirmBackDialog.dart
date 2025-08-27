import 'package:flutter/material.dart';

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
          children: [
            Text("Deseja sair? Você perderá todas as alterações! "),
            Row(
              children: [

                //cancel button
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
                    icon: Icons.check)

              ],
            )
          ],
    ),
    );
  }
}

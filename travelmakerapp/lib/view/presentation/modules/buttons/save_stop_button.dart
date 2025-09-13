import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../dialogs/errorDialog.dart';
import 'customButton.dart';

class SaveStopButton extends StatelessWidget {
  const SaveStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);

    return Row(
      children: [
        Expanded(
          child: MediumButton2(
              onTap: (){

                final createStop = createTravelProvider.createStop();
                if(!createStop.success){
                  showDialog(
                      context: context,
                      builder: (context) => ErrorDialog(textError: createStop.message!)
                  );
                } else if(createStop.success){
                  Navigator.of(context).pop();
                  createTravelProvider.clearStopData();

                }

              },
              text: "Adicionar parada",
              icon: Icons.add_location_alt_outlined),
        ),
      ],
    );
  }
}

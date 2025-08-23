import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/customDialog.dart';
import 'package:travelmakerapp/usecase/forms/travelForm/get_error_string.dart';

// Dialog widget
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.textError});

  final String textError;

  @override
  Widget build(BuildContext context) {
    String error = getErrorString(textError, context);
    return CustomDialog2(
      title: "Ops! Temos um problema!",
      icon: Icons.priority_high,
      widget: Column(
        spacing: 10,
          children: [
            SizedBox(height: 5,),
            Text(error, style: Theme.of(context).textTheme.displaySmall,),
            SmallButton1(
                onTap: (){
                  Navigator.of(context).pop();
                },
                text: "Entendi!",
                icon: Icons.new_releases
            )
          ]
      ),
    );
  }
}

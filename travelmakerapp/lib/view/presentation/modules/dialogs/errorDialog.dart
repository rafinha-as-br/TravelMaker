import 'package:flutter/material.dart';
import 'package:travelmakerapp/view/presentation/helpers/get_error_string.dart';
import '../../../../l10n/app_localizations.dart';
import '../buttons/customButton.dart';
import 'customDialog.dart';

// Dialog widget
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.textError});

  final String textError;

  @override
  Widget build(BuildContext context) {
    String error = getErrorString(textError, context);
    return CustomDialog2(
      title: AppLocalizations.of(context)!.haveProblem,
      icon: Icons.priority_high,
      widget: Column(
        spacing: 10,
          children: [
            SizedBox(height: 5,),
            Text(textError, style: Theme.of(context).textTheme.displaySmall,),
            SmallButton1(
                onTap: (){
                  Navigator.of(context).pop();
                },
                text: AppLocalizations.of(context)!.understood,
                icon: Icons.new_releases
            )
          ]
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/presentation/modules/customDialog.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';

import '../../../l10n/app_localizations.dart';

class ParticipantDialog extends StatefulWidget {
  ParticipantDialog({super.key, this.person});

  Person? person;

  @override
  State<ParticipantDialog> createState() => _ParticipantDialogState();
}

class _ParticipantDialogState extends State<ParticipantDialog> {
  final _formKey = GlobalKey<FormState>();

  final participantName = TextEditingController();

  final participantAge = TextEditingController();


  //to reload the ui when the user type
  @override
  void initState() {
    super.initState();
    participantName.addListener(() {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {



    return CustomDialog(
        title: "Participante",
      widget: Column(
        children: [
          // person info
          Column(
            children: [
              //picture
              CircleAvatar(),
              //name and age
              Text(
                participantName.text.isEmpty
                    ? "Nome do participante, Idade"
                    : "${participantName.text}, ${participantAge.text.isEmpty ? 'Idade' : participantAge.text}",
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          ),

          // form
          Form(
            key: _formKey,
              child: Column(
                children: [
                  //name formField
                  CustomTextFormField1(
                    title: "Nome",
                    controller: participantName,
                    validator: (value){
                      if(value==null){
                        return AppLocalizations.of(context)!.yourNameError1;
                      }
                      if(value.length<2){
                        return AppLocalizations.of(context)!.yourNameError2;
                      }
                      return null;
                    }
                  ),

                  //age formField
                  CustomTextFormField1(
                    title: "Nome",
                    controller: participantAge,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.yourAgeError3;
                      }

                      final number = int.tryParse(value);
                      if (number == null) {
                        return AppLocalizations.of(context)!.yourAgeError1;
                      }

                      if (number < 0) {
                        return AppLocalizations.of(context)!.yourAgeError2;
                      }

                      return null;
                    }
                  ),


                ],
              )
          )

          // save button
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/customDialog.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

import '../../../l10n/app_localizations.dart';
import '../../provider/createTravelProvider.dart';

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
    participantAge.addListener((){
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);

    return CustomDialog(
        title: "Participante",
      widget: Column(
        children: [
          // person info
          Column(
            spacing: 15,
            children: [
              SizedBox(
                height: 1,
              ),
              //picture
              Consumer<CreateTravelProvider>(
                builder: (context, travelProvider, child) {
                  return InkWell(
                    onTap: () {
                      travelProvider.selectProfilePicture();
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: widget.person == null
                                  ? null
                                  : FileImage(File(widget.person!.profilePicture.toString())),
                              child: travelProvider.profilePicture == null
                                  ? Icon(Icons.person, size: 45, color: getBackgroundColor())
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: getPrimaryColor(),
                                child: Icon(Icons.camera_alt,
                                    size: 16, color: getBackgroundColor()
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                            widget.person == null ? "Toque para adicionar foto" : "Toque para substituir a foto",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: getPrimaryColor(),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),              //name and age
              Text(
                participantName.text.isEmpty
                    ? "Nome do participante, Idade"
                    : "${participantName.text}, ${participantAge.text.isEmpty ? 'Idade' : participantAge.text}",
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          ),

          Container(
            width: 200,
              child: Divider(
                thickness: 1.4,
                color: getPrimaryColor(),
              )
          ),


          // form
          Form(
            key: _formKey,
              child: Column(
                spacing: 20,
                children: [
                  //name formField
                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: CustomTextFormField1(
                            title: "Nome",
                            controller: participantName,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                showDialog(
                                    context: context,
                                    builder: (context) => ErrorDialog(textError: AppLocalizations.of(context)!.yourNameError1)
                                );
                                return '';
                              } else if(value.length<2){
                                showDialog(
                                    context: context,
                                    builder: (context) => ErrorDialog(textError: AppLocalizations.of(context)!.yourNameError2)
                                );
                                return '';
                              } else{
                                return null;
                              }

                            }
                        ),
                      ),

                      //age formField
                      Expanded(
                        child: CustomTextFormField1(
                            title: "Idade",
                            controller: participantAge,
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) => ErrorDialog(textError: AppLocalizations.of(context)!.yourAgeError3)
                                );
                              }

                              final number = int.tryParse(value);
                              if (number == null) {
                                showDialog(
                                    context: context,
                                    builder: (context) => ErrorDialog(textError: AppLocalizations.of(context)!.yourAgeError1)
                                );
                                return null;
                              }

                              if (number < 0) {
                                showDialog(
                                    context: context,
                                    builder: (context) => ErrorDialog(textError: AppLocalizations.of(context)!.yourAgeError2)
                                );
                              }

                              return null;
                            }
                        ),
                      ),
                    ],
                  ),

                  //save button
                  MediumButton2(
                      onTap: (){
                        if(_formKey.currentState!.validate() != false){
                          Navigator.of(context).pop();
                          print("Adicionou a pessoa!");
                        }
                      },
                      text: widget.person == null ? "Adicionar pessoa" : "Salvar alterações",
                      icon: Icons.abc
                  )
                ],
              )
          )

          // save button
        ],
      ),
    );
  }
}

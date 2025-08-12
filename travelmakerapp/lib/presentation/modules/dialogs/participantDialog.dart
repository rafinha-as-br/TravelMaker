import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/customDialog.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/presentation/provider/personProvider.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

import '../../../l10n/app_localizations.dart';
import '../../provider/createTravelProvider.dart';

class ParticipantDialog extends StatefulWidget {
  ParticipantDialog({super.key});

  @override
  State<ParticipantDialog> createState() => _ParticipantDialogState();
}

class _ParticipantDialogState extends State<ParticipantDialog> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> nameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> ageFieldKey = GlobalKey<FormFieldState>();

  final participantName = TextEditingController();
  final participantAge = TextEditingController();


  //to reload the ui when the user type
  @override
  void initState() {
    super.initState();

    participantName.addListener(() => setState(() {}));
    participantAge.addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<PersonProvider>();

      if (p.editMode) {
        participantName.text = p.person.name;
        participantAge.text = p.person.age.toString();
      }
    });
  }





  @override
  Widget build(BuildContext context) {

    return Consumer<PersonProvider>(
      builder: (context, p, child) {
        final createTravelProvider = Provider.of<CreateTravelProvider>(context);

        return CustomDialog(
          title: "Participante",
          widget: Column(
            children: [

              // person info
              Column(
                spacing: 15,
                children: [
                  SizedBox(height: 1),
                  //picture
                  InkWell(
                    onTap: () {
                      p.selectProfilePicture();
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: p.person.profilePicture == null
                                  ? null
                                  : FileImage(
                                      File(p.person.profilePicture.toString()),
                                    ),
                              child: p.person.profilePicture == null
                                  ? Icon(
                                      Icons.person,
                                      size: 45,
                                      color: getBackgroundColor(),
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: getPrimaryColor(),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: getBackgroundColor(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.person.profilePicture == null
                              ? "Toque para adicionar foto"
                              : "Toque para substituir a foto",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: getPrimaryColor(),
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  ), //name and age
                  Text(
                    participantName.text.isEmpty
                        ? "Nome do participante, Idade"
                        : "${participantName.text}, ${participantAge.text.isEmpty ? 'Idade' : participantAge.text}",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),

              Container(
                width: 200,
                child: Divider(thickness: 1.4, color: getPrimaryColor()),
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
                            formFieldKey: nameFieldKey,
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                return 'empty';
                              }
                              if (value.length < 2) {
                                return 'short';
                              }
                              return null;
                            },
                          ),
                        ),

                        //age formField
                        Expanded(
                          child: CustomTextFormField1(
                            title: "Idade",
                            controller: participantAge,
                            formFieldKey: ageFieldKey,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'empty';
                              }
                              final num = int.tryParse(value);
                              if (num == null) {
                                return 'notNumber';
                              }
                              if (num < 0) {
                                return 'negative';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    //save button
                    MediumButton2(
                      onTap: () {
                        if (_formKey.currentState!.validate() != false) {
                          Person person = Person(
                            name: participantName.text,
                            age: int.parse(participantAge.text),
                            profilePicture: p.person.profilePicture,
                          );

                          if (p.editMode) {
                            //if is in edit mode, overrides the person in the selected index
                            createTravelProvider.updatePersonsList(person, index: p.editIndex);
                          } else {
                            createTravelProvider.updatePersonsList(person);
                          }
                          p.resetPersonProvider();
                          p.editPersonMode(false);
                          Navigator.of(context).pop();


                          print("Adicionou a pessoa!");
                        } else {
                          String? error;
                          print("teste else form");

                          if (nameFieldKey.currentState?.errorText != null) {
                            error = nameFieldKey.currentState!.errorText;
                            if (error == 'empty') {
                              error = AppLocalizations.of(
                                context,
                              )!.yourNameError1;
                            } else if (error == 'short') {
                              error = AppLocalizations.of(
                                context,
                              )!.yourNameError2;
                            }
                          } else if (ageFieldKey.currentState?.errorText !=
                              null) {
                            error = ageFieldKey.currentState!.errorText;
                            if (error == 'empty') {
                              error = AppLocalizations.of(
                                context,
                              )!.yourAgeError3;
                            } else if (error == 'notNumber') {
                              error = AppLocalizations.of(
                                context,
                              )!.yourAgeError1;
                            } else if (error == 'negative') {
                              error = AppLocalizations.of(
                                context,
                              )!.yourAgeError2;
                            }
                          }

                          if (error != null) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  ErrorDialog(textError: error!),
                            );
                          }
                        }
                      },
                      text: p.editMode == false
                          ? "Adicionar pessoa"
                          : "Salvar alterações",
                      icon: Icons.abc,
                    ),
                  ],
                ),
              ),

              // save button
            ],
          ),
        );
      },
    );
  }
}

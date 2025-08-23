import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/customDialog.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/presentation/provider/personProvider.dart';

import '../../../Themes/getTheme.dart';
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




  //to reload the ui when the user type
  @override
  void initState() {
    super.initState();



    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<PersonProvider>();

      p.personNameController.addListener(() => setState(() {}));
      p.personAgeController.addListener(() => setState(() {}));

      if (p.editMode) {
        p.personNameController.text = p.person.name;
        p.personAgeController.text = p.person.age.toString();
      }
    });
  }





  @override
  Widget build(BuildContext context) {

    return Consumer<PersonProvider>(
      builder: (context, p, child) {
        final createTravelProvider = Provider.of<CreateTravelProvider>(context);

        return CustomDialog(
          title: AppLocalizations.of(context)!.participant,
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
                              ? AppLocalizations.of(context)!.addPhoto
                              : AppLocalizations.of(context)!.replacePhoto,
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
                    p.personNameController.text.isEmpty
                        ? "Nome do participante, Idade"
                        : "${p.personNameController.text}, ${p.personAgeController.text.isEmpty ? 'Idade' : p.personAgeController.text}",
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
                            title: AppLocalizations.of(context)!.name,
                            controller: p.personNameController,
                            formFieldKey: nameFieldKey,
                          ),
                        ),

                        //age formField
                        Expanded(
                          child: CustomTextFormField1(
                            title: AppLocalizations.of(context)!.age,
                            controller: p.personAgeController,
                            formFieldKey: ageFieldKey,

                          ),
                        ),
                      ],
                    ),

                    //save button
                    MediumButton2(
                      onTap: () {

                        //validates the person
                        final validatePerson = p.validatePerson();
                        if(!validatePerson.success){
                          showDialog(
                              context: context,
                              builder: (context) => ErrorDialog(textError: validatePerson.message!)
                          );
                        } else{
                          // add to list
                          if (p.editMode) {
                            //if is in edit mode, overrides the person in the selected index
                            createTravelProvider.updatePersonsList(p.person, index: p.editIndex);
                          } else {
                            createTravelProvider.updatePersonsList(p.person);
                          }
                          p.resetPersonProvider();
                          p.toogleEditPersonMode(false);
                          Navigator.of(context).pop();
                          print("Person added to travel of provider!");
                        }

                      },
                      text: p.editMode == false
                          ? AppLocalizations.of(context)!.addPerson
                          : AppLocalizations.of(context)!.saveAlterations,
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

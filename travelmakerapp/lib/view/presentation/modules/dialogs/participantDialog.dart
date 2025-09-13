import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/person.dart';
import 'package:travelmakerapp/interface_adapters/providers/personProvider.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/selectVehicleDialog.dart';
 import '../../../../entities/vehicles.dart';
import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../helpers/getVehicleIcons.dart';
import '../buttons/customButton.dart';
import '../containers/container_customContainer.dart';
import '../customExpansionTile.dart';
import '../customTextFormField.dart';
import 'customDialog.dart';
import 'errorDialog.dart';

class ParticipantDialog extends StatefulWidget {
  final CreateTravelProvider createTravelProvider;
  const ParticipantDialog({super.key, required this.createTravelProvider});

  @override
  State<ParticipantDialog> createState() => _ParticipantDialogState();
}

class _ParticipantDialogState extends State<ParticipantDialog> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> nameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> ageFieldKey = GlobalKey<FormFieldState>();


  @override
  Widget build(BuildContext context) {


    return Consumer<PersonProvider>(
      builder: (context, p, child) {

        return CustomDialog(
          title: AppLocalizations.of(context)!.participant,
          onClose: ()  {
              Navigator.of(context).pop();
              p.resetPersonControllers();
          },
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
                              backgroundImage: p.profilePicturePath == null
                                  ? null
                                  : FileImage(
                                      File(p.profilePicturePath.toString()),
                                    ),
                              child: p.profilePicturePath == null
                                  ? Icon(
                                      Icons.person,
                                      size: 45,
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.profilePicturePath == null
                              ? AppLocalizations.of(context)!.addPhoto
                              : AppLocalizations.of(context)!.replacePhoto,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              Container(
                width: 200,
                child: Divider(thickness: 1.4, color: Theme.of(context).primaryColor),
              ),

              // form
              Form(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  children: [

                    Text('Nome e idade da pessoa: ', style: Theme.of(context).textTheme.displaySmall,),

                    Row(
                      spacing: 15,
                      children: [
                        //name
                        Expanded(
                          child: CustomTextFormField1(
                            title: AppLocalizations.of(context)!.name,
                            controller: p.personNameController,
                          ),
                        ),

                        //age
                        Expanded(
                          child: CustomTextFormField1(
                            title: AppLocalizations.of(context)!.age,
                            controller: p.personAgeController,

                          ),
                        ),


                      ],
                    ),

                    Text("Selecione o veículo de preferência desta pessoa: ", style: Theme.of(context).textTheme.displaySmall,),
                    //preferred vehicle selector
                    MediumButton1(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) => SelectVehicleDialog()
                          );
                          p.toggleVehicleExpanded(true);
                        },
                        text: p.vehicleChosen == Vehicles.notSelected ?
                          'Selecionar o veículo' :
                            '${p.vehicleChosen.name}'
                        ,
                        icon: p.vehicleChosen == Vehicles.notSelected ?
                            Icons.search :
                            getVehicleIcons(p.vehicleChosen)
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
                          Person person = Person(
                              name: p.personNameController.text,
                              age: int.parse(p.personAgeController.text),
                              preferredVehicle: p.vehicleChosen,
                              profilePicture: p.profilePicturePath,
                          );

                          // add to list
                          if (p.editMode) {
                            //if is in edit mode, overrides the person in the selected index
                            widget.createTravelProvider.updatePersonsList(person, index: p.editIndex);
                          } else {
                            widget.createTravelProvider.updatePersonsList(person);
                          }
                          p.resetPersonControllers();
                          p.toogleEditPersonMode(false);
                          Navigator.of(context).pop();
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import 'package:travelmakerapp/interface_adapters/providers/personProvider.dart';
import 'package:travelmakerapp/view/presentation/helpers/getVehicleIcons.dart';
import 'package:travelmakerapp/view/presentation/helpers/getVehicleName.dart';
import 'package:travelmakerapp/view/presentation/helpers/get_error_string.dart';
import '../../../../Themes/getTheme.dart';
import '../../../../entities/validator.dart';
import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../page/stopScreen.dart';
import '../buttons/customButton.dart';
import '../cards/stopCard.dart';
import '../containers/customContainer.dart';
import '../customChip.dart';
import '../customExpansionTile.dart';
import '../customListView.dart';
import '../customTextFormField.dart';
import '../dialogs/errorDialog.dart';
import '../dialogs/experienceDialog.dart';
import '../inputDecoration.dart';
import '../dialogs/participantDialog.dart';

class TravelForm extends StatelessWidget {
  TravelForm({super.key});
  static const routeName = '/travelForm';

  final _formKey = GlobalKey<FormState>();
  final travelTitle = TextEditingController();
  final travelDescription = TextEditingController();
  final travelDestination = TextEditingController();
  final travelFinalDate = TextEditingController();

  final GlobalKey<FormFieldState> travelDescriptionFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDestinationFormKey = GlobalKey<FormFieldState>();


  @override
  Widget build(BuildContext context) {

    //createTravelProvider instance, because of it's size, we're calling him CTP
    final ctp = Provider.of<CreateTravelProvider>(context);
    final personProvider = Provider.of<PersonProvider>(context);

    //adds the user to the participants lists
    if(ctp.userAdded == false){
      ctp.addUserToPersonList();
      ctp.userAdded = true;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Form(
        key: _formKey,
          child: Column(
            spacing: 20,
            children: [

              // travel title
              CustomContainer1(widget: Column(
                    spacing: 15,
                    children: [
                      CustomSubContainer1(
                          text1: AppLocalizations.of(context)!.giveTravelTitle,
                          text2: AppLocalizations.of(context)!.travelTitleText,
                          icon: Icons.text_fields
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField1(
                          title: AppLocalizations.of(context)!.title,
                          controller: ctp.travelTitleController,
                          formFieldKey: ctp.travelTitleFormFieldKey,
                        ),
                      )
                    ],
                  ),),

              // travel description ("what is the objetive of this travel?")
              CustomContainer1(widget: Column(
                spacing: 15,
                    children: [
                      CustomSubContainer1(
                          text1: AppLocalizations.of(context)!.giveTravelDescription,
                          text2: AppLocalizations.of(context)!.travelDescriptionText,
                          icon: Icons.short_text
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField3(
                          title: AppLocalizations.of(context)!.description,
                          controller: ctp.travelDescriptionController,
                          formFieldKey: ctp.travelDescriptionFormFieldKey,
                        ),
                      )
                    ],
                  ),),

              // final destination
              CustomContainer1(widget: Column(
                spacing: 15,
                  children: [
                    CustomSubContainer1(
                        text1: AppLocalizations.of(context)!.finalDestinationTitle,
                        text2: AppLocalizations.of(context)!.finalDestination,
                        icon: Icons.my_location
                    ),
                    
                    // get final city textField
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextFormField2(
                          controller: ctp.travelDestinationController,
                          formFieldKey: ctp.travelDestinationFormFieldKey,
                          onSelect: (suggestion) {
                            ctp.toggleTravelDestinationController(suggestion);
                            ctp.getTravelDestinationCoordinates(suggestion);
                            print("Latitude: ${ctp.travelDestinationLatitude}");
                            print("Latitude: ${ctp.travelDestinationLongitude}");
                          },
                      ),
                    )
                  ],
                ),),

              // participants selector
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.person_add, color: getPrimaryColor(),),
                          Text(AppLocalizations.of(context)!.addParticipants, style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text(AppLocalizations.of(context)!.addParticipantsText, style: Theme.of(context).textTheme.displaySmall,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Customexpansiontile(
                        title: AppLocalizations.of(context)!.participants,
                        initiallyExpanded: true,
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //Participants
                            CustomListView(
                                personsList: ctp.travelPersonsList,
                                editOnTap: (index){
                                  //toogle edit mode
                                  personProvider.toogleEditPersonMode(true);
                                  // set the person that is going to be edited
                                  personProvider.setPersonToEdit(ctp.travelPersonsList[index], index);
                                  // call the person dialog
                                  showDialog(
                                      context: context,
                                      builder: (context) => ParticipantDialog()
                                  );
                                },
                                removeOnTap: (index) {
                                  ctp.removePerson(index);

                                }
                            ),

                            // add participants button
                            Row(
                              children: [
                                Expanded(
                                  child: SmallButton1(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) => ParticipantDialog()
                                        );
                                      },
                                      text: AppLocalizations.of(context)!.addParticipantsButtonText,
                                      icon: Icons.add
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                    ),
                  ),
                ],
              )),

              // date selector for start and finish of the travel (datePicker)
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.date_range, color: getPrimaryColor(),),
                          Text(AppLocalizations.of(context)!.startEndDate, style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text(AppLocalizations.of(context)!.startEndDateText, style: Theme.of(context).textTheme.displaySmall,)

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      spacing: 45,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration(AppLocalizations.of(context)!.startDate, context),
                            style: Theme.of(context).textTheme.displaySmall,
                            readOnly: true,
                            controller: ctp.travelStartDateController,
                            onTap: (){
                              ctp.selectTravelStartDate(context);
                            },
                          ),

                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration(AppLocalizations.of(context)!.endDate, context),
                            style: Theme.of(context).textTheme.displaySmall,
                            readOnly: true,
                            controller: ctp.travelFinalDateController,
                            onTap: (){
                              ctp.selectTravelFinalDate(context);
                            },
                          ),

                        ),
                      ],
                    ),
                  ),

                ],
              )),

              // desired vehicle selector (same as participants but with inkwell)
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.emoji_transportation, color: getPrimaryColor(),),
                          Text(AppLocalizations.of(context)!.desiredTransportTitle, style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text(AppLocalizations.of(context)!.desiredTransportText, style: Theme.of(context).textTheme.displaySmall,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Consumer<CreateTravelProvider>(builder: (context, p, child){
                      return Customexpansiontile(
                        // bool to close the expansion tile when ListTileSelected
                        key: ValueKey(p.isVehicleExpanded),
                        title: p.vehicleChosen == Vehicles.notSelected ?
                        AppLocalizations.of(context)!.vehicles :
                        "${AppLocalizations.of(context)!.chosenMean} ${getVehicleName(p.vehicleChosen, context)}",
                        initiallyExpanded: p.isVehicleExpanded,
                        widget: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Vehicles.values.length-1,
                          itemBuilder: (context, index){
                            final vehicle = Vehicles.values[index];

                            return ListTile(
                                title: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: p.vehicleChosen == vehicle ?
                                  BoxDecoration(
                                      border: Border.all(color: getPrimaryColor(), width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                  ): null,
                                  child: InkWell(
                                    onTap: (){
                                      p.selectVehicle(vehicle);
                                      p.toggleVehicleExpanded(false);
                                    },
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        SizedBox(width: 10,),
                                        Text(getVehicleName(vehicle, context), style: Theme.of(context).textTheme.displaySmall,),
                                        Icon(getVehicleIcons(vehicle), color: getPrimaryColor(),)
                                      ],
                                    ),
                                  ),
                                )
                            );
                          },
                        ),
                      );
                    }

                    )
                  )
                ],
              )),

              // add a travel stop (anoter dialog widget)
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.location_on, color: getPrimaryColor(),),
                          Text(AppLocalizations.of(context)!.travelStopTitle, style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text(
                        AppLocalizations.of(context)!.travelStopText,
                        style: Theme.of(context).textTheme.displaySmall,
                      )
                    ],
                  ),

                  Customexpansiontile(
                      title: AppLocalizations.of(context)!.travelStopsText2,
                      initiallyExpanded: true,
                      widget: Column(
                        children: [
                          // stop lists
                          ctp.travelStopList.isEmpty ?
                          Column(
                            children: [
                              SizedBox(height: 20,),
                              Text('Nenhuma parada adicionada', style: Theme.of(context).textTheme.displaySmall,),
                              SizedBox(height: 20,),
                            ],
                          ) :
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ctp.travelStopList.length,
                              itemBuilder: (context, index){
                                return ListTile(
                                    title: StopCard(travelStop: ctp.travelStopList[index], index: index),
                                    onTap:(){
                                      ctp.setStopEdit(ctp.travelStopList[index], index, context);
                                      Navigator.pushNamed(context, StopScreen.routeName);
                                    }
                                );

                              }
                          ),

                          // add stopButton (goes and open another page)
                          Row(
                            children: [
                              Expanded(
                                  child: SmallButton1(
                                      onTap: (){
                                        Navigator.pushNamed(context, StopScreen.routeName);
                                      },
                                      text: AppLocalizations.of(context)!.addTravelStop,
                                      icon: Icons.flag)
                              )
                            ],
                          ),

                          SizedBox(height: 10,)

                        ],
                      ),

                  ),
                ],
              )),

              // experience area
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  Column(
                    children: [
                      Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.bookmark_add, color: getPrimaryColor(), size: 35,),
                          Text(AppLocalizations.of(context)!.experiences, style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text(AppLocalizations.of(context)!.experiencesText, style: Theme.of(context).textTheme.displaySmall,)
                    ],
                  ),

                  // experiences list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 1,
                      children: ctp.experiencesList.isEmpty ?
                          [Text(AppLocalizations.of(context)!.experiencesEmpty, style: Theme.of(context).textTheme.displaySmall, )] :
                          ctp.experiencesList.map((experience) {
                        bool isSelected = ctp.experiencesList.contains(experience);
                        return ExperienseChip(experience.name, isSelected, context);
                      }).toList(),
                    ),
                  ),

                  // add experience (call a dialog)
                  Row(
                    children: [
                      Expanded(
                        child: SmallButton1(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context) => ExperienceDialog()
                              );
                            },
                            text: AppLocalizations.of(context)!.addExperience,
                            icon: Icons.airline_stops_rounded),
                      ),
                    ],
                  )

                ],
              )),

              //map route maybe?


              // save button
              Row(
                children: [
                  Expanded(
                    child: MediumButton2(
                        onTap: (){
                          Validator validateTravel = ctp.createTravel();
                          if(validateTravel.success == true && validateTravel.message == null){
                            print("Sucesso ao criar viagem!");
                            // add travel to user and to the database
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => ErrorDialog(textError: validateTravel.message!)
                            );
                          }

                        },
                        text: AppLocalizations.of(context)!.createTravelButton,
                        icon: Icons.airplane_ticket_outlined
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50,)

            ],
          )
      ),
    );
  }
}



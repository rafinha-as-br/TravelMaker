import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/containers/customContainer.dart';
import 'package:travelmakerapp/presentation/modules/customExpansionTile.dart';
import 'package:travelmakerapp/presentation/modules/customListView.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/stopForm.dart';
import 'package:travelmakerapp/presentation/provider/personProvider.dart';
import 'package:travelmakerapp/usecase/forms/travelForm/getVehicleIcons.dart';
import 'package:travelmakerapp/usecase/forms/travelForm/travel_form_validators.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/googleAPI.dart';
import '../../../usecase/Themes/getTheme.dart';
import '../../provider/createTravelProvider.dart';
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
                          title: "Título",
                          controller: ctp.travelTitle,
                          formFieldKey: ctp.travelTitleFormFieldKey,
                          validator: (value) => TravelFormValidators.travelTitleValidator(value)
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
                        child: CustomTextFormField1(
                          title: "Descrição",
                          controller: ctp.travelDescription,
                          formFieldKey: ctp.travelDescriptionFormFieldKey,
                          validator: (value) => TravelFormValidators.travelDescriptionValidator(value),
                        ),
                      )
                    ],
                  ),),

              // final destination Refactoring DONe
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
                          controller: ctp.travelDestination, 
                          formFieldKey: ctp.travelDestinationFormFieldKey,
                          onSelect: (description) => ctp.toggleTravelDestinationController(description),
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
                                  personProvider.editPersonMode(true);
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
                                      text: AppLocalizations.of(context)!.addParticipantsText,
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
                          Text('Data de início e conclusão', style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text("Quando vamos começar esta viagem e até quando ela durará?", style: Theme.of(context).textTheme.displaySmall,)

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      spacing: 45,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration("Data início", context),
                            readOnly: true,
                            controller: ctp.travelStartDateController,
                            onTap: (){
                              ctp.selectTravelStartDate(context);
                            },
                          ),

                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration("Data final", context),
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
                          Text("Meio de transporte desejado", style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text("Escolha meio de transporte você prefere utilizar nesta viagem!", style: Theme.of(context).textTheme.displaySmall,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Consumer<CreateTravelProvider>(builder: (context, p, child){
                      return Customexpansiontile(
                        key: ValueKey(p.isVehicleExpanded),
                        title: p.vehicleChosen == Vehicles.notSelected ?
                        "Veículos" : "Meio escolhido: ${p.vehicleChosen.name}",
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
                                        Text(vehicle.name, style: Theme.of(context).textTheme.displaySmall,),
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
                          Text('Paradas da viagem', style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text(
                        "Antes de chegar ao destino final, que tal fazer um passeio em algum lugar?",
                        style: Theme.of(context).textTheme.displaySmall,
                      )
                    ],
                  ),

                  Customexpansiontile(
                      title: "Paradas da viagem",
                      widget: Column(
                        children: [
                          // stop lists
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ctp.travelStopList.length,
                              itemBuilder: (context, index){
                                return Container();
                              }
                          ),

                          // add stopButton (goes and open another page)
                          Row(
                            children: [
                              Expanded(
                                  child: SmallButton1(
                                      onTap: (){
                                        Navigator.pushNamed(context, Stopform.routeName);
                                      },
                                      text: "Adicionar parada",
                                      icon: Icons.flag)
                              )
                            ],
                          ),

                          SizedBox(height: 10,)

                        ],
                      ),
                      initiallyExpanded: true),
                ],
              )),

              //map route maybe?


              // save button
              Row(
                children: [
                  Expanded(
                    child: MediumButton2(
                        onTap: (){},
                        text: "Criar viagem",
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



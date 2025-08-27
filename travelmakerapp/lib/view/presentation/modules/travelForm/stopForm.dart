import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/services/googleAPI.dart';
import '../../../../Themes/getTheme.dart';
import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../buttons/customButton.dart';
import '../containers/customContainer.dart';
import '../customTextFormField.dart';
import '../dateDisplayer.dart';
import '../dialogs/errorDialog.dart';
import '../inputDecoration.dart';

class StopForm extends StatelessWidget {
  StopForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final stopCity = TextEditingController();
  final GlobalKey<FormFieldState> cityFormKey = GlobalKey<FormFieldState>();




  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);

    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            spacing: 20,
            children: [

              // city name
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  CustomSubContainer1(
                      text1: 'Cidade da parada',
                      text2: 'Escolha uma cidade para visitar ou conhecer!',
                      icon: Icons.location_city
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextFormField2(
                          controller: createTravelProvider.stopDestinationController,
                          formFieldKey: createTravelProvider.stopDestinationFormKey,
                          onSelect: (suggestion) {

                            createTravelProvider.stopDestinationLatitude.text = suggestion['lat'].toString();
                            createTravelProvider.stopDestinationLongitude.text = suggestion['lng'].toString();
                            createTravelProvider.toggleStopDestinationController(suggestion['description']);
                            FocusScope.of(context).unfocus();
                          }
                      )
                  )
                ],
              )),

              // description
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
                      title: "Descrição",
                      controller: createTravelProvider.stopDescriptionController,
                      formFieldKey: createTravelProvider.stopDescriptionFormKey,
                    ),
                  )
                ],
              ),),

              // date selector
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.edit_calendar, color: getPrimaryColor(), size: 35,),
                          Text("Datas de chegada e partida", style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text("Toda parada você tem um dia para chegar e ir embora, qual são esses dias?", style: Theme.of(context).textTheme.displaySmall,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      spacing: 30,
                      children: [
                        Expanded(
                            child: TextFormField(
                                decoration: getInputDecoration("Data chegada", context),
                                style: Theme.of(context).textTheme.displaySmall,
                                controller: createTravelProvider.stopStartDateController,
                                readOnly: true,

                                onTap: (){
                                  createTravelProvider.selectTStopStartDate(context);
                                }
                            )

                        ),
                        Expanded(
                            child: TextFormField(
                                decoration: getInputDecoration("Data saída", context),
                                style: Theme.of(context).textTheme.displaySmall,
                                controller: createTravelProvider.stopFinalDateController,
                                readOnly: true,

                                onTap: (){
                                  createTravelProvider.selectTStopFinalDate(context);
                                }
                            )
                        ),
                      ],
                    ),
                  )
                ],
              )),

              // time spent displayer
              CustomContainer1(widget: Column(
                spacing: 15,
                children: [
                  Column(
                    children: [
                      Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.timelapse, color: getPrimaryColor(), size: 35,),
                          Text("Tempo gasto previsto", style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                    ],
                  ),
                  dateDisplayer(
                      createTravelProvider.stopStartDate,
                      createTravelProvider.stopFinalDate,
                      context
                  )
                ],
              )),

              //save button
              Row(
                children: [
                  Expanded(
                    child: MediumButton2(
                        onTap: (){

                          final validateStop = createTravelProvider.validateStop();
                          if(!validateStop.success){
                            showDialog(
                                context: context,
                                builder: (context) => ErrorDialog(textError: validateStop.message!)
                            );
                          } else if(validateStop.success){
                            Navigator.of(context).pop();
                            createTravelProvider.clearStopData();

                          }

                        },
                        text: "Adicionar parada",
                        icon: Icons.add_location_alt_outlined),
                  ),
                ],
              ),

              SizedBox(
                height: 50,
              )

            ],
          ),
        ));
  }
}

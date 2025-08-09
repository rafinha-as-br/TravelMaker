import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/vehicles.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/customContainer.dart';
import 'package:travelmakerapp/presentation/modules/customExpansionTile.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/stopForm.dart';
import 'package:travelmakerapp/usecase/forms/travelForm/getVehicleIcons.dart';
import '../../../l10n/app_localizations.dart';
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

  final GlobalKey<FormFieldState> travelTitleFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDescriptionFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> travelDestinationFormKey = GlobalKey<FormFieldState>();


  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);


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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 15,
                            children: [
                              Icon(Icons.text_fields, color: getPrimaryColor(),),
                              Text('Dê um título a sua viagem!', style: Theme.of(context).textTheme.displayMedium,),
                            ],
                          ),
                          Divider(thickness: 1, color: getPrimaryColor(),),
                          Text("Toda viagem precisa de um nome memorável, qual será o nome desta viagem?", style: Theme.of(context).textTheme.displaySmall,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField1(
                          title: "Título",
                          controller: travelTitle,
                          formFieldKey: travelTitleFormKey,
                          validator: (value){
                            if(value==null) {
                              return 'Você precisa adicionar um título a sua viagem!';
                            }
                            if(value.length<2){
                              return 'Não é possível adicionar um título menor que 3 caracteres';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),),

              // travel description ("what is the objetive of this travel?")
              CustomContainer1(widget: Column(
                spacing: 15,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 15,
                            children: [
                              Icon(Icons.short_text, color: getPrimaryColor(),),
                              Text("Dê uma descrição da viagem!", style: Theme.of(context).textTheme.displayMedium,),
                            ],
                          ),
                          Divider(thickness: 1, color: getPrimaryColor(),),
                          Text("O que você quer anotar de mais importante desta viagem para não esquecer?", style: Theme.of(context).textTheme.displaySmall,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField1(
                          title: "Descrição",
                          controller: travelDescription,
                          formFieldKey: travelDescriptionFormKey,
                          validator: (value){
                            if(value==null) {
                              return 'Você precisa adicionar uma descrição a sua viagem!';
                            }
                            if(value.length<2){
                              return 'Não é possível adicionar uma descrição menor que 3 caracteres';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),),

              // final destination
              CustomContainer1(widget: Column(
                spacing: 15,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 15,
                          children: [
                            Icon(Icons.my_location, color: getPrimaryColor(),),
                            Text("Destino final", style: Theme.of(context).textTheme.displayMedium,),
                          ],
                        ),
                        Divider(thickness: 1, color: getPrimaryColor(),),
                        Text("Toda viagem tem um destino final, qual é o desta vez?", style: Theme.of(context).textTheme.displaySmall,)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextFormField1(
                        title: "Cidade final",
                        controller: travelDestination,
                        formFieldKey: travelDestinationFormKey,
                        validator: (value){
                          if(value==null) {
                            return 'Você precisa adicionar o destino final (cidade) da sua viagem!';
                          }
                          if(value.length<2){
                            return 'Não é possível pegar cidades menores que 3 caracteres';
                          }
                          return null;
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
                          Text("Adicione participantes", style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                      Divider(thickness: 1, color: getPrimaryColor(),),
                      Text("Adicione os companheiros dessa viagem!", style: Theme.of(context).textTheme.displaySmall,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Customexpansiontile(
                        title: "Participantes",
                        initiallyExpanded: true,
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Participants
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: createTravelProvider.travelPersonsList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 35,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          //name
                                          Text(
                                            "${createTravelProvider.travelPersonsList[index].name}, ",
                                            style: Theme.of(context).textTheme.displaySmall,
                                          ),
                                          //age
                                          Text(
                                            "${createTravelProvider.travelPersonsList[index].age.toString()}"
                                                " ${AppLocalizations.of(context)!.years}",
                                            style: Theme.of(context).textTheme.displaySmall,
                                          ),
                                        ],
                                      ),

                                      //actions buttons
                                      Row(
                                        children: [
                                          VerticalDivider(thickness: 1, color: getPrimaryColor(),),
                                          IconButton(
                                            onPressed: (){},
                                            icon: Icon(
                                              Icons.edit,
                                              color: getPrimaryColor(),
                                              size: 15,
                                            ),
                                            padding: EdgeInsetsGeometry.zero,
                                            constraints: BoxConstraints(),
                                          ),
                                          IconButton(
                                              onPressed: (){},
                                              icon: Icon(
                                                Icons.delete,
                                                color: getPrimaryColor(),
                                                size: 15,
                                              ),
                                              padding: EdgeInsetsGeometry.zero,
                                              constraints: BoxConstraints(),

                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                );
                              },
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
                                      text: "Adicionar participante",
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
                            controller: createTravelProvider.travelStartDate,
                            onTap: (){
                              createTravelProvider.selectDate(context);
                            },
                          ),

                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: getInputDecoration("Data final", context),
                            readOnly: true,
                            controller: createTravelProvider.travelFinalDate,
                            onTap: (){
                              createTravelProvider.selectDate(context);
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
                    child: Customexpansiontile(
                        title: "Veículos",
                        initiallyExpanded: true,
                        widget: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Vehicles.values.length,
                          itemBuilder: (context, index){
                            final vehicle = Vehicles.values[index];

                            return ListTile(
                              title: InkWell(
                                onTap: (){
                                  print("Apertou!");
                                },
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Text(vehicle.name, style: Theme.of(context).textTheme.displaySmall,),
                                    Icon(getVehicleIcons(vehicle), color: getPrimaryColor(),)
                                  ],
                                ),
                              )
                            );
                          },
                        ),
                    ),
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
                          )



                        ],
                      ),
                      initiallyExpanded: true),
                ],
              )),

              //maybe an text?


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



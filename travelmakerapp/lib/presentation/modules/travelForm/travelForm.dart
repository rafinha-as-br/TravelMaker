import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/customContainer.dart';
import 'package:travelmakerapp/presentation/modules/customExpansionTile.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/stopForm.dart';
import '../../../usecase/Themes/getTheme.dart';
import '../../provider/createTravelProvider.dart';
import '../inputDecoration.dart';
import 'addParticipantDialog.dart';

class TravelForm extends StatelessWidget {
  TravelForm({super.key});
  static const routeName = '/travelForm';

  final _formKey = GlobalKey<FormState>();
  final travelTitle = TextEditingController();
  final travelDescription = TextEditingController();
  final travelDestination = TextEditingController();
  final travelFinalDate = TextEditingController();

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
                      Text('Título da viagem'),
                      CustomTextFormField1(
                        title: "Título",
                        controller: travelTitle,
                        validator: (value){
                          if(value==null) {
                            return 'Você precisa adicionar um título a sua viagem!';
                          }
                          if(value.length<2){
                            return 'Não é possível adicionar um título menor que 3 caracteres';
                          }
                          return null;
                        },
                      )
                    ],
                  ),),

              // travel description ("what is the objetive of this travel?")
              CustomContainer1(widget: Column(
                    children: [
                      Text('Descrição da viagem'),
                      CustomTextFormField1(
                        title: "Descrição",
                        controller: travelDescription,
                        validator: (value){
                          if(value==null) {
                            return 'Você precisa adicionar uma descrição a sua viagem!';
                          }
                          if(value.length<2){
                            return 'Não é possível adicionar uma descrição menor que 3 caracteres';
                          }
                          return null;
                        },
                      )
                    ],
                  ),),

              // final destination
              CustomContainer1(widget: Column(
                  children: [
                    Text('Destino final'),
                    CustomTextFormField1(
                      title: "Cidade final",
                      controller: travelDestination,
                      validator: (value){
                        if(value==null) {
                          return 'Você precisa adicionar o destino final (cidade) da sua viagem!';
                        }
                        if(value.length<2){
                          return 'Não é possível pegar cidades menores que 3 caracteres';
                        }
                        return null;
                      },
                    )
                  ],
                ),),

              // participants selector (create a dialog widget)
              CustomContainer1(widget: Column(
                children: [
                  Text('Participantes'),
                  Customexpansiontile(
                      title: "Participantes",
                      initiallyExpanded: true,
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Participants
                          SizedBox(
                            width: 200,
                            height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: createTravelProvider.personsList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Card(
                                    child: Row(
                                      children: [
                                        Text(createTravelProvider.personsList[index].name),
                                        Text(createTravelProvider.personsList[index].age.toString()),
                                        Divider(thickness: 1, color: getPrimaryColor(),)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // add participants button
                          Row(
                            children: [
                              Expanded(
                                child: Button1(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context) => Addparticipantdialog()
                                      );
                                    },
                                    text: "Adicionar participante",
                                    icon: Icons.add
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ),
                ],
              )),

              // date selector for start and finish of the travel (datePicker)
              CustomContainer1(widget: Column(
                children: [
                  Text('Selecione a data de início e de conclusão da viagem',),
                  Row(
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

                ],
              )),

              // desired vehicle selector (same as participants but with inkwell)
              CustomContainer1(widget: Column(
                children: [
                  Text("Veículo desejado"),
                  Customexpansiontile(
                      title: "Veículos",
                      initiallyExpanded: true,
                      widget: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: createTravelProvider.vehicles.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Row(
                              children: [
                                Text(createTravelProvider.vehicles[index]),
                              ],
                            ),
                          );
                        },
                      ),
                  )
                ],
              )),

              // add a travel stop (anoter dialog widget)
              CustomContainer1(widget: Column(
                children: [
                  Text('Paradas da viagem'),

                  Customexpansiontile(
                      title: "Paradas da viagem",
                      widget: Column(
                        children: [
                          // stop lists


                          // add stopButton (goes and open another page)
                          Row(
                            children: [
                              Expanded(
                                  child: Button1(
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


              // save button
              Row(
                children: [
                  Expanded(
                    child: Button1(
                        onTap: (){},
                        text: "Criar viagem",
                        icon: Icons.airplane_ticket_outlined
                    ),
                  ),
                ],
              )

            ],
          )
      ),
    );
  }
}



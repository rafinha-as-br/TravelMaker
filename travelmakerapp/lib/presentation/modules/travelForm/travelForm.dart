import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelDesiredVehicles.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelParticipantsExpansionTile.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelStopDialog.dart';
import 'package:travelmakerapp/usecase/dates/getDate.dart';
import '../../../usecase/Themes/getTheme.dart';
import '../../provider/createTravelProvider.dart';
import '../inputDecoration.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Form(
        key: _formKey,
          child: Column(
            spacing: 30,
            children: [

              // travel title
              Column(
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
              ),

              // travel description ("what is the objetive of this travel?")
              Column(
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
              ),

              // final destination
              Column(
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
              ),

              // participants selector (create a dialog widget)
              Column(
                children: [
                  Text('Participantes'),
                  TravelParticipantsExpansionTile(),
                ],
              ),


              // date selector for start and finish of the travel (datePicker)
              Column(
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
              ),

              // desired vehicle selector (same as participants but with inkwell)
              Column(
                children: [
                  Text("Veículo desejado"),
                  Traveldesiredvehicles(),
                ],
              ),

              // add a travel stop (anoter dialog widget)
              Column(
                children: [
                  Text('Paradas da viagem'),
                  TravelStopExpansionTile(),
                ],
              ),


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



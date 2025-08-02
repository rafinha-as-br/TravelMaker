import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelDesiredVehicles.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelParticipants.dart';
import 'package:travelmakerapp/usecase/dates/getDate.dart';

import '../../../l10n/app_localizations.dart';
import '../../../usecase/Themes/getTheme.dart';
import '../../provider/createTravelProvider.dart';
import '../inputDecoration.dart';

class TravelForm extends StatelessWidget {
  TravelForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final travelTitle = TextEditingController();
  final travelDescription = TextEditingController();
  final travelDestination = TextEditingController();
  final travelFinalDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          child: Column(
            children: [

              // travel title
              Container(
                child: Column(
                  children: [
                    Text('Título da viagem'),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: getInputDecoration("Título", context),
                      style: Theme.of(context).textTheme.displaySmall,
                      cursorColor: getPrimaryColor(),
                      keyboardType: TextInputType.text,
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
              ),

              // travel description ("what is the objetive of this travel?")
              Container(
                child: Column(
                  children: [
                    Text('Descrição da viagem'),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: getInputDecoration('Descrição', context),
                      style: Theme.of(context).textTheme.displaySmall,
                      cursorColor: getPrimaryColor(),
                      keyboardType: TextInputType.text,
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
              ),

              // final destination
              Container(
                child: Column(
                  children: [
                    Text('Destino final'),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: getInputDecoration('Cidade final', context),
                      style: Theme.of(context).textTheme.displaySmall,
                      cursorColor: getPrimaryColor(),
                      keyboardType: TextInputType.text,
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
              ),

              // participants selector (create a dialog widget)
              Text('Participantes'),
              TravelParticipants(),


              // date selector for start and finish of the travel (datePicker)
              Text('Selecione a data de início e de conclusão da viagem'),
              Row(
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


              // desired vehicle selector (same as participants but with inkwell)
              Text("Veículo desejado"),
              Traveldesiredvehicles(),
              // add a travel stop (anoter dialog widget)

              // save button
              Container(
                width: 200,
                child: Button1(
                    onTap: (){},
                    text: "Criar viagem",
                    icon: Icons.airplane_ticket_outlined
                ),
              )

            ],
          )
      ),
    );
  }
}

Future<void> selectDate(BuildContext context, TextEditingController date) async{
  DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: getDate(),
      firstDate: getDate(),
      lastDate: DateTime(2026)
  );
  if(selectedDate != null){
    date.text = selectedDate.toString();
  }

}

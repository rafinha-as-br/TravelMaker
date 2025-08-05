import 'package:flutter/material.dart';

import '../../../usecase/Themes/getTheme.dart';
import '../inputDecoration.dart';

class Stopform extends StatelessWidget {
  const Stopform({super.key});

  static const routeName = '/travelStopForm';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar uma parada"),
      ),
      body: Form(
        child: Column(
          children: [

            // city selector
            Row(
              children: [
                Text("Qual a cidade de parada?"),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: getInputDecoration("Cidade", context),
                  style: Theme.of(context).textTheme.displaySmall,
                  cursorColor: getPrimaryColor(),
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value==null) {
                      return 'Você precisa informar a cidade de parada!';
                    }
                    if(value.length<2){
                      return 'Não é possível encontrar cidades com menos de 2 caracteres!';
                    }
                    return null;
                  },
                )
              ],
            ),

            // get coords (future)


            // Date selector


            // experienses


            // time spend in stop


          ],
        ),
      ),
    );
  }
}

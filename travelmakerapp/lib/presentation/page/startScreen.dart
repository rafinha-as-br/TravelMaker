import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/user.dart';
import 'package:travelmakerapp/presentation/modules/startScreen_title.dart';
import 'package:travelmakerapp/presentation/modules/toggleThemeButton.dart';
import 'package:travelmakerapp/presentation/page/homeScreen.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';

import '../modules/toggleLanguageButton.dart';

class StartScreen extends StatelessWidget {

  static const routeName = '/StartScreen';

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();


  StartScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final entities = Provider.of<EntitiesProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Togglelanguagebutton(),
                Togglethemebutton(),
              ],
            ),
            StartscreenTitle(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Seu nome"),
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    validator: (value){
                      if(value==null){
                        return "Você precisa informar seu nome!";
                      }
                      if(value.length<2){
                        return "Nome deve conter pelo menos uma letra";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Seu(a) idade"),
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a idade';
                      }

                      final number = int.tryParse(value);
                      if (number == null) {
                        return 'Digite um número válido';
                      }

                      if (number < 0) {
                        return 'Idade não pode ser negativa';
                      }

                      return null;
                    },
                  ),
                  ElevatedButton(onPressed: () {
                    if(_formKey.currentState!.validate()){
                      int? age = int.tryParse(ageController.text);
                      entities.createPerson(nameController.text, age!);
                      User user = User(nameController.text, age, true);
                      entities.user = user;

                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }

                  }, child: Text("Continuar")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/button1.dart';
import 'package:travelmakerapp/usecase/appLoader.dart';

import '../../entities/user.dart';
import '../page/homeScreen.dart';
import '../provider/userProvider.dart';

class UserForm extends StatelessWidget {
  UserForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Form(
        key: _formKey,
        child: Column(
          spacing: 10,
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
          Button1(onTap: (){
            user.setUserData(nameController.text, int.parse(ageController.text), true);
            Apploader();
          }, text: 'Salvar', icon: Icons.save)
        ],
      )
    );
  }
}

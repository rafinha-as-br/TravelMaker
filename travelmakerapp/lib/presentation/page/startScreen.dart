import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  static const routeName = '/StartScreen';

  //provisional place where the colors are
  static const Color backgroundColor = Color.fromRGBO(100, 100, 100, 100);




  static final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final state = Provider.of<EntitiesProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
        child: Column(
          children: [
            Text('Olá! Seja bem vindo!'),
            SizedBox(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Antes de começarmos, informe seu nome e sua idade!'),
                  TextField(decoration: InputDecoration(labelText: "Seu nome")),
                  TextField(
                    decoration: InputDecoration(labelText: "Seu(a) idade"),
                  ),
                  ElevatedButton(onPressed: () {


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

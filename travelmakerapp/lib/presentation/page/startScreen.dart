import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  static const routeName = '/StartScreen';

  //provisional place where the colors are
  static const Color backgroundColor = Color.fromRGBO(100, 100, 100, 100);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<>(context);


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
        child: Column(
          children: [
            Text('Olá! Seja bem vindo!'),
            SizedBox(),  

          ],
        ),
      ),
    );
  }
}

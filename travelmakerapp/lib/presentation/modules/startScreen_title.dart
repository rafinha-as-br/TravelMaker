import 'package:flutter/material.dart';

class StartscreenTitle extends StatelessWidget {
  const StartscreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Olá! Seja bem vindo!', style: Theme.of(context).textTheme.displayLarge,)
            ],
          ),
          Image.asset('assets/images/Logo1.png', width: 300, height: 150,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Antes de começarmos', style: Theme.of(context).textTheme.displayMedium)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Informe seu nome e sua idade', style: Theme.of(context).textTheme.displayMedium)
            ],
          )
        ],
      ),
    );
  }
}

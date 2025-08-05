import 'package:flutter/material.dart';

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

              ],
            )

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

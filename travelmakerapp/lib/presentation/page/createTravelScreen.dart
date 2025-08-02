import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelForm.dart';

class CreateTravelScreen extends StatelessWidget {
  const CreateTravelScreen({super.key});

  static const routeName = '/CreateTravelScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TravelForm(),
              ],
            ),
          ),
        )
      ),
    );
  }
}

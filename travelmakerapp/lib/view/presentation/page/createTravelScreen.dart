import 'package:flutter/material.dart';

import '../modules/travelForm/travelForm.dart';
class CreateTravelScreen extends StatelessWidget {
  const CreateTravelScreen({super.key});

  static const routeName = '/CreateTravelScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Criando uma viagem!", style: Theme.of(context).textTheme.displayMedium,),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            floating: true,
            snap: true,
            elevation: 0,
            
            backgroundColor:  Theme.of(context).canvasColor,
          ),
          SliverToBoxAdapter(
            child: TravelForm(),
          )
        ],
      ),
    );
  }
}

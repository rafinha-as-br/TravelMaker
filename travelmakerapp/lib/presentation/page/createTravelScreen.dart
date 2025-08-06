import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelForm.dart';

import '../../usecase/Themes/getTheme.dart';

class CreateTravelScreen extends StatelessWidget {
  const CreateTravelScreen({super.key});

  static const routeName = '/CreateTravelScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Criando uma viagem!"),
            floating: true,
            snap: true,
            elevation: 0,
            
            backgroundColor: getCanvasColor(),
          ),
          SliverToBoxAdapter(
            child: TravelForm(),
          )
        ],
      ),
    );
  }
}

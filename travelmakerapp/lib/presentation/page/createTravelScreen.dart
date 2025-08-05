import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/travelForm/travelForm.dart';

import '../../usecase/Themes/getTheme.dart';

class CreateTravelScreen extends StatelessWidget {
  const CreateTravelScreen({super.key});

  static const routeName = '/CreateTravelScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: getPrimaryColor()),
        backgroundColor: getCanvasColor(),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Column(
              children: [
                // title
                // subtitle
              ],
            )
        ),

      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TravelForm(),
            ],
          ),
        ),
      ),
    );
  }
}

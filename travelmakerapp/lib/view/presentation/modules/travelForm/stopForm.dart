import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/buttons/save_stop_button.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/stop_city.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/stop_date_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/stop_description.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/stop_time_spent.dart';


class StopForm extends StatelessWidget {
  StopForm({super.key});

  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            spacing: 20,
            children: [

              // city name
              StopCityContainer(),

              // description
              StopDescriptionContainer(),

              // date selector
              StopDateSelectorContainer(),

              // time spent displayer
              StopTimeSpentContainer(),

              //save button
              SaveStopButtonContainer(),

              SizedBox(
                height: 50,
              )

            ],
          ),
        ));
  }
}

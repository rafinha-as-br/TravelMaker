import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/buttons/save_stop_alterations_button.dart';
import 'package:travelmakerapp/view/presentation/modules/buttons/save_stop_button.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_stop_city.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_stop_date_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_stop_description.dart';

import '../../../../entities/appState.dart';
import '../../../../interface_adapters/providers/AppStateProvider.dart';
import '../containers/container_time_spent_displayer.dart';


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



              //time spent displayer TODO => NEED TO CHECK WHY IS NOT SHOWING THE TIME ANYMORE
              StopTimeSpentContainer(),


              // save or edit button
              Selector<AppStateProvider, AppStatus>(
                selector: (_, asp) => asp.appStatus,
                builder: (context, status, child) {
                  switch(status){
                    case AppStatus.creatingTravel:
                      return SaveStopButton();
                    case AppStatus.editingTravel:
                      return SaveStopAlterationsButton();
                    default:
                      return Text('error!');
                  }

                },
              ),

              SizedBox(
                height: 50,
              )

            ],
          ),
        ));
  }
}

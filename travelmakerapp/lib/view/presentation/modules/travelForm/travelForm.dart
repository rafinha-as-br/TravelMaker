import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/modules/buttons/create_travel_button.dart';
import 'package:travelmakerapp/view/presentation/modules/buttons/save_travel_alterations_button.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_vehicle_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_add_experience.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_add_stop.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_date_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_participants_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_travel_description.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_travel_destinations.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_travel_title.dart';
import '../../../../entities/appState.dart';
import '../../../../interface_adapters/providers/createTravelProvider.dart';



class TravelForm extends StatelessWidget {
  TravelForm({super.key});
  static const routeName = '/travelForm';

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    //createTravelProvider instance, because of it's size, we're calling him CTP
    final ctp = Provider.of<CreateTravelProvider>(context);

    // create the formControllers inside CTP

    // here the screen verifies what state of the app is to
    // create the relative widgets!
    // if is in editing mode, add all the data inside formControllers (call an function from ctp)





    //adds the user to the participants lists
    if(ctp.userAdded == false){
      ctp.addUserToPersonList();
      ctp.userAdded = true;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Form(
        key: _formKey,
          child: Column(
            spacing: 20,
            children: [

              // travel title
              TravelTitleContainer(),

              // travel description ("what is the objetive of this travel?")
              TravelDescriptionContainer(),

              // travel start & final destination
              TravelDestinationsContainer(),

              // date selector for start and finish of the travel (datePicker)
              DateSelectorContainer(),

              // participants selector
              ParticipantsSelectorContainer(),

              // desired vehicle selector (same as participants but with inkwell)
              VehicleSelectorContainer(),

              // add a travel stop (anoter dialog widget)
              AddStopContainer(),

              // experience area
              AddExperienceContainer(),

              //map route maybe?


              // save or edit button
              Selector<AppStateProvider, AppStatus>(
                selector: (_, asp) => asp.appStatus,
                builder: (context, status, child) {
                  switch(status){
                    case AppStatus.creatingTravel:
                      return CreateTravelButton();
                    case AppStatus.editingTravel:
                      return SaveTravelAlterationsButton();
                    default:
                      return Text('error!');
                  }

                },
              ),



              SizedBox(height: 50,)

            ],
          )
      ),
    );
  }
}



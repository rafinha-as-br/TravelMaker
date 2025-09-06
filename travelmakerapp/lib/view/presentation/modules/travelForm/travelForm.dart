import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/%20vehicle_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/add_experience.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/add_travel.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/date_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/participants_selector.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/travel_description.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/travel_destinations.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/travel_title.dart';
import 'package:travelmakerapp/view/presentation/page/loading_screen.dart';
import '../../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../buttons/customButton.dart';
import '../dialogs/errorDialog.dart';


class TravelForm extends StatelessWidget {
  TravelForm({super.key});
  static const routeName = '/travelForm';

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    //createTravelProvider instance, because of it's size, we're calling him CTP
    final ctp = Provider.of<CreateTravelProvider>(context);

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

              // participants selector
              ParticipantsSelectorContainer(),

              // date selector for start and finish of the travel (datePicker)
              DateSelectorContainer(),

              // desired vehicle selector (same as participants but with inkwell)
              VehicleSelectorContainer(),

              // add a travel stop (anoter dialog widget)
              AddTravelContainer(),

              // experience area
              AddExperienceContainer(),

              //map route maybe?


              // save button
              Row(
                children: [
                  Expanded(
                    child: MediumButton2(
                        onTap: () async{
                          final createTravel = await ctp.createTravel();
                          if(!createTravel.success && context.mounted){
                            showDialog(
                                context: context,
                                builder: (context) => ErrorDialog(textError: createTravel.message!)
                            );
                          } else{
                            // cleaning the controllers
                            ctp.clearTravelData();

                            //sending to the home page
                            Navigator.pushNamed(context, AppLoaderScreen.routeName);
                          }

                        },
                        text: AppLocalizations.of(context)!.createTravelButton,
                        icon: Icons.airplane_ticket_outlined
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50,)

            ],
          )
      ),
    );
  }
}



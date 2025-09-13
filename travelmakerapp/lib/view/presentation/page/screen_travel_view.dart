import 'dart:io';
import 'package:flutter/material.dart';
import '../../../entities/Travel.dart';
import '../../../l10n/app_localizations.dart';
import '../helpers/dates/dateFormat.dart';
import '../helpers/getVehicleName.dart';
import '../modules/cards/stopCard.dart';
import '../modules/inputDecoration.dart';

/// This screen is to visualize an specific travel and it's info
class TravelScreen extends StatelessWidget {
  ///
  const TravelScreen({super.key, required this.travel});

  /// travel that is going to be visualized
  final Travel travel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).cardColor,
            centerTitle: true,
            title: const Text('status'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "editar") {

                  } else if (value == "excluir") {

                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "editar",
                    child: Text("Editar viagem"),
                  ),
                  const PopupMenuItem(
                    value: "excluir",
                    child: Text("Excluir viagem"),
                  ),
                ],
              ),
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Text(travel.travelName)
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              spacing: 15,
              children: [

                /// destination
                Row(
                  children: [
                    Text(
                      "Destino final: ",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      travel.finish.city,
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                ),

                /// TODO Travel map (widget)
                ///
                /// Start And conclusion days
                Row(
                  spacing: 20,
                  children: [
                    //start
                    Column(
                      children: [
                        Text(
                          'Início',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        TextField(
                          readOnly: true,
                          decoration: getInputDecoration(
                            getFormatedDate2(travel.origin.departureDate),
                            context),
                        )
                      ],
                    ),

                    //conclusion
                    Column(
                      children: [
                        Text(
                          'chegada',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        TextField(
                          readOnly: true,
                          decoration: getInputDecoration(
                            getFormatedDate2(travel.finish.arrivalDate),
                            context
                          ),
                        )
                      ],
                    )
                  ],
                ),

                /// selected way of transport
                Row(
                  children: [
                    Text(
                      'Meio de transporte',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    TextField(
                      readOnly: true,
                      decoration: getInputDecoration(
                        getVehicleName(travel.desiredVehicle, context),
                        context
                      ),
                    )
                  ],
                ),

                /// Participants
                Column(
                  children: [
                    Text(
                      "Participantes",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    ListView.builder( /// TODO: REFACTOR INTO ANOTHER WIDGET
                        itemCount: travel.membersList.length,
                        itemBuilder: (context, index){
                          final person = travel.membersList[index];
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                backgroundImage:
                                  person.profilePicture == null ?
                                    null :
                                    FileImage(
                                      File(
                                          person.profilePicture!
                                      ),
                                    ),
                                child: person.profilePicture == null ?
                                Icon(
                                  Icons.person,
                                  size: 10,
                                  color: Theme.of(context).primaryColor,
                                ) :
                                null,
                              ),

                              SizedBox(width: 5,),
                              //name
                              Text(
                                '${person.name}, ',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              //age
                              Text(
                                '${person.age.toString()}'
                                    ' ${AppLocalizations.of(context)!.years}',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          );
                        }
                    )
                  ],
                ),

                /// StopList   TODO -> CREATE ANOTHER WIDGET
                ListView.builder(
                  itemCount: travel.travelStopList.length,
                  itemBuilder: (context, index){
                    final stop = travel.travelStopList[index];
                    final stopStatus = stop.checkStopStatus();

                    return StopCard(
                      travelStop: stop,
                      index: index,
                      stopStatus: stopStatus,
                    );
                  }
                )

                /// TODO conclude travel button

              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/customChip.dart';
import 'package:travelmakerapp/presentation/modules/customContainer.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';

import '../../../usecase/Themes/getTheme.dart';
import '../../provider/createTravelProvider.dart';
import '../inputDecoration.dart';

class Stopform extends StatelessWidget {
  Stopform({super.key});

  static const routeName = '/travelStopForm';

  final _formKey = GlobalKey<FormState>();
  final stopCity = TextEditingController();
  final arrivalDate = TextEditingController();
  final departureDate = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final createTravelProvider = Provider.of<CreateTravelProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Adicionar parada", style: Theme.of(context).textTheme.displayMedium,),
            iconTheme: IconThemeData(color: getPrimaryColor()),
            backgroundColor: getCanvasColor(),
            floating: true,
            snap: true,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: Column(
                    spacing: 20,
                    children: [
                      // city name
                      CustomContainer1(widget: Column(
                        spacing: 15,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Cidade da parada", style: Theme.of(context).textTheme.displayMedium,),
                              Divider(thickness: 1, color: getPrimaryColor(),),
                              Text("Escolha uma cidade para visitar, conhecer e descobrir!", style: Theme.of(context).textTheme.displaySmall,)
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField1(
                                title: "Cidade",
                                controller: stopCity,
                                validator: (value){

                                }),
                          )
                        ],
                      )),

                      // date selector
                      CustomContainer1(widget: Column(
                        spacing: 15,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Datas de chegada e partida", style: Theme.of(context).textTheme.displayMedium,),
                              Divider(thickness: 1, color: getPrimaryColor(),),
                              Text("Toda parada você tem um dia para chegar e ir embora, qual são esses dias?", style: Theme.of(context).textTheme.displaySmall,)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              spacing: 45,
                              children: [
                                Expanded(
                                    child: CustomTextFormField1(
                                        title: "Data chegada",
                                        controller: arrivalDate,
                                        validator: (value){

                                        }
                                    )
                                ),
                                Expanded(
                                    child: CustomTextFormField1(
                                        title: "Data saída",
                                        controller: departureDate,
                                        validator: (value){

                                        }
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                      ),

                      // experience area
                      CustomContainer1(widget: Column(
                        spacing: 15,
                        children: [
                          Column(
                            children: [
                              Text("Experiências", style: Theme.of(context).textTheme.displayMedium,),
                              Divider(thickness: 1, color: getPrimaryColor(),),
                              Text("Subtitulo", style: Theme.of(context).textTheme.displaySmall,)
                            ],
                          ),

                          // experiences list
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 1,
                              children: Experiences.values.map((experience) {
                                return experienseChip(experience.name);
                              }).toList(),
                            ),
                          ),

                          // add experience (call a dialog)
                          Row(
                            children: [
                              Expanded(
                                child: Button1(
                                    onTap: (){},
                                    text: "Adicionar experiência",
                                    icon: Icons.airline_stops_rounded),
                              ),
                            ],
                          )

                        ],
                      )),


                      // time spent displayer
                      CustomContainer1(widget: Column(
                        spacing: 15,
                        children: [
                          Column(
                            children: [
                              Text("Tempo gasto previsto", style: Theme.of(context).textTheme.displayMedium,),
                              Divider(thickness: 1, color: getPrimaryColor(),),
                            ],
                          ),
                          Text(".... Dias", style: Theme.of(context).textTheme.displayLarge,)
                        ],
                      )),

                      //save button
                      Row(
                        children: [
                          Expanded(
                            child: Button1(
                                onTap: (){},
                                text: "Adicionar parada",
                                icon: Icons.add_location_alt_outlined),
                          ),
                        ],
                      )

                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

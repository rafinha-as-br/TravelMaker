import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/customChip.dart';
import 'package:travelmakerapp/presentation/modules/customContainer.dart';
import 'package:travelmakerapp/presentation/modules/customTextFormField.dart';
import 'package:travelmakerapp/services/googleAPI.dart';

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
  final GlobalKey<FormFieldState> cityFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> arrivalDateFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> departureDateFormKey = GlobalKey<FormFieldState>();



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
                              Row(
                                spacing: 15,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_city, color: getPrimaryColor(), size: 35,),
                                  Text("Cidade da parada", style: Theme.of(context).textTheme.displayMedium,),
                                ],
                              ),
                              Divider(thickness: 1, color: getPrimaryColor(),),
                              Text("Escolha uma cidade para visitar, conhecer e descobrir!", style: Theme.of(context).textTheme.displaySmall,)
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: TypeAheadField<Map<String, dynamic>>(
                              suggestionsCallback: (pattern) async {
                                if (pattern.isEmpty) return [];
                                return await fetchCitySuggestions(pattern);
                              },
                              emptyBuilder: (context){
                                return SizedBox.shrink();
                              },
                              decorationBuilder: (context, child) {
                                return Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(15),
                                  color: getCanvasColor(),
                                  child: SingleChildScrollView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      child: child
                                  ),
                                );
                              },
                              builder: (context, controller, focusNode) {
                                controller.text = stopCity.text;

                                controller.addListener(() {
                                  if (stopCity.text != controller.text) {
                                    stopCity.text = controller.text;
                                  }
                                });


                                focusNode.addListener(() {
                                  if (focusNode.hasFocus) {
                                    Scrollable.ensureVisible(
                                      cityFormKey.currentContext!,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      alignment: 0.35,
                                    );
                                  }
                                });


                                return TextField(
                                  cursorColor: getPrimaryColor(),
                                  style: Theme.of(context).textTheme.displaySmall,
                                  textAlign: TextAlign.center,
                                  controller: controller,
                                  key: cityFormKey,
                                  focusNode: focusNode,
                                  decoration: getInputDecoration("Digite a cidade", context),
                                );
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  tileColor: getCanvasColor(),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                                  title: Text(suggestion['description'], style: Theme.of(context).textTheme.displaySmall,),
                                );
                              },
                              onSelected: (suggestion) async {
                                print('Cidade escolhida: ${suggestion['description']}');
                                print('Lat: ${suggestion['lat']}, Lng: ${suggestion['lng']}');
                                stopCity.text = suggestion['description'];

                              },
                            ),
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
                              Row(
                                spacing: 15,
                                children: [
                                  Icon(Icons.edit_calendar, color: getPrimaryColor(), size: 35,),
                                  Text("Datas de chegada e partida", style: Theme.of(context).textTheme.displayMedium,),
                                ],
                              ),
                              Divider(thickness: 1, color: getPrimaryColor(),),
                              Text("Toda parada você tem um dia para chegar e ir embora, qual são esses dias?", style: Theme.of(context).textTheme.displaySmall,)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              spacing: 30,
                              children: [
                                Expanded(
                                    child: CustomTextFormField1(
                                        title: "Data chegada",
                                        controller: arrivalDate,
                                        formFieldKey: arrivalDateFormKey,
                                        validator: (value){

                                        }
                                    )
                                ),
                                Expanded(
                                    child: CustomTextFormField1(
                                        title: "Data saída",
                                        controller: departureDate,
                                        formFieldKey: departureDateFormKey,
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
                              Row(
                                spacing: 15,
                                children: [
                                  Icon(Icons.bookmark_add, color: getPrimaryColor(), size: 35,),
                                  Text("Experiências", style: Theme.of(context).textTheme.displayMedium,),
                                ],
                              ),
                              Divider(thickness: 1, color: getPrimaryColor(),),
                              Text("O que você quer viver nesta parada?", style: Theme.of(context).textTheme.displaySmall,)
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
                                child: SmallButton1(
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
                              Row(
                                spacing: 15,
                                children: [
                                  Icon(Icons.timelapse, color: getPrimaryColor(), size: 35,),
                                  Text("Tempo gasto previsto", style: Theme.of(context).textTheme.displayMedium,),
                                ],
                              ),
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
                            child: MediumButton2(
                                onTap: (){},
                                text: "Adicionar parada",
                                icon: Icons.add_location_alt_outlined),
                          ),
                        ],
                      ),



                      SizedBox(
                        height: 50,
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

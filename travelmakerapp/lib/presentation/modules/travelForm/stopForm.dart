import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/customChip.dart';
import 'package:travelmakerapp/presentation/modules/containers/customContainer.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/experienceDialog.dart';
import 'package:travelmakerapp/services/googleAPI.dart';
import '../../../usecase/Themes/getTheme.dart';
import '../../provider/createTravelProvider.dart';
import '../dialogs/errorDialog.dart';
import '../inputDecoration.dart';

class Stopform extends StatelessWidget {
  Stopform({super.key});

  static const routeName = '/travelStopForm';

  final _formKey = GlobalKey<FormState>();
  final stopCity = TextEditingController();
  final GlobalKey<FormFieldState> cityFormKey = GlobalKey<FormFieldState>();




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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              builder: (context, internalController, focusNode) {
                                internalController.text=createTravelProvider.stopDestination.text;

                                internalController.addListener(() {
                                  if (createTravelProvider.stopDestination.text != internalController.text) {
                                    createTravelProvider.stopDestination.text=internalController.text;
                                  }
                                });

                                focusNode.addListener(() {
                                  if (focusNode.hasFocus) {
                                    Scrollable.ensureVisible(
                                      createTravelProvider.stopDestinationFormKey.currentContext!,
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
                                  controller: internalController,
                                  key: createTravelProvider.stopDestinationFormKey,
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

                              // set false because the widget is already forcing hiding inside the onSelected function (both activated gets a double focus bug)
                              hideOnSelect: false,

                              onSelected: (suggestion) async {
                                print('Cidade escolhida: ${suggestion['description']}');
                                print('Lat: ${suggestion['lat']}, Lng: ${suggestion['lng']}');
                                createTravelProvider.stopDestinationLatitude.text = suggestion['lat'].toString();
                                createTravelProvider.stopDestinationLongitude.text = suggestion['lng'].toString();
                                createTravelProvider.toggleStopDestinationController(suggestion['description']);
                                FocusScope.of(context).unfocus();

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
                                    child: TextFormField(
                                        decoration: getInputDecoration("Data chegada", context),
                                        style: Theme.of(context).textTheme.displaySmall,
                                        controller: createTravelProvider.stopStartDateController,
                                        readOnly: true,

                                        onTap: (){
                                          createTravelProvider.selectTStopStartDate(context);
                                        }
                                    )

                                ),
                                Expanded(
                                    child: TextFormField(
                                        decoration: getInputDecoration("Data saída", context),
                                        style: Theme.of(context).textTheme.displaySmall,
                                        controller: createTravelProvider.stopFinalDateController,
                                        readOnly: true,

                                        onTap: (){
                                          createTravelProvider.selectTStopFinalDate(context);
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
                              children: createTravelProvider.experiencesList.map((experience) {
                                bool isSelected = createTravelProvider.experiencesList.contains(experience);
                                return ExperienseChip(experience.name, isSelected, context);
                              }).toList(),
                            ),
                          ),

                          // add experience (call a dialog)
                          Row(
                            children: [
                              Expanded(
                                child: SmallButton1(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context) => ExperienceDialog()
                                      );
                                    },
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
                          createTravelProvider.isDatesSelected() ?
                            Text("${createTravelProvider.daysSpent(createTravelProvider.stopStartDate!, createTravelProvider.stopFinalDate!)} Dias ", style: Theme.of(context).textTheme.displayLarge,) :
                              Text("Selecione as datas de início e fim!")

                        ],
                      )),



                      //save button
                      Row(
                        children: [
                          Expanded(
                            child: MediumButton2(
                                onTap: (){
                                  createTravelProvider.addStop();
                                  if(createTravelProvider.error != null){
                                    showDialog(
                                        context: context,
                                        builder: (context) => ErrorDialog(textError: createTravelProvider.error!)
                                    );
                                  }
                                },
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

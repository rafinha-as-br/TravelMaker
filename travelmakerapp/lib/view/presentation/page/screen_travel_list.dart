import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/cards/travel_card.dart';
import 'package:travelmakerapp/view/presentation/modules/customLoadingWidget.dart';
import 'package:travelmakerapp/view/presentation/page/screen_travel_view.dart';


import '../../../interface_adapters/providers/AppStateProvider.dart';

/// Screen to view all the travels of the user
class TravelListScreen extends StatelessWidget {
  ///
  const TravelListScreen({super.key});

  ///route name
  static const routeName = '/TravelListScreen';


  @override
  Widget build(BuildContext context) {
    final asp = Provider.of<AppStateProvider>(context);


    return FutureBuilder(
      future: asp.getTravels(),
      builder: (context, asyncSnapshot) {
        if(!asyncSnapshot.hasData){
          return CustomLoadingWidget();
        }
        if(asyncSnapshot.hasData){
        }
        final data = asyncSnapshot.data;
        if(!data!.$1.success && context.mounted){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Error'),
            ),
          );
        }
        if(data.$2.isEmpty){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('nenhuma viagem adicionada!'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).canvasColor,
            title: Text(
              'Listar as suas viagens!',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: asyncSnapshot.data!.$2.length,
                itemBuilder: (context, index){
                  final travel = asyncSnapshot.data!.$2[index];
                  final travelStatus = travel.checkTravelStatus();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TravelCard(
                      travel: travel,
                      travelStatus: travelStatus,
                    ),
                  );
                }
            ),
          ),
        );


      }
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/cards/travel_card.dart';
import 'package:travelmakerapp/view/presentation/modules/customLoadingWidget.dart';
import 'package:travelmakerapp/view/presentation/page/travel_screen.dart';


import '../../../interface_adapters/providers/AppStateProvider.dart';

class TravelListScreen extends StatelessWidget {
  const TravelListScreen({super.key});

  static const routeName = '/TravelListScreen';


  @override
  Widget build(BuildContext context) {
    final asp = Provider.of<AppStateProvider>(context);


    return FutureBuilder(
      future: asp.getTravels(),
      builder: (context, asyncSnapshot) {
        if(!asyncSnapshot.hasData){
          print("no data!");
          return CustomLoadingWidget();
        }
        if(asyncSnapshot.hasData){
          print("Has data!");
        }
        final data = asyncSnapshot.data;
        if(!data!.$1.success && context.mounted){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text("Error"),
            ),
          );
        }
        if(data.$2.isEmpty){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text("nenhuma viagem adicionada!"),
            ),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  'Listar as suas viagens!',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        onTap: (){
                          TravelScreen(travel: asyncSnapshot.data!.$2[index]);
                        },
                        title: TravelCard(
                          travel: asyncSnapshot.data!.$2[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                  childCount: asyncSnapshot.data?.$2.length ?? 0,
                ),
              ),            ],
          ),
        );


      }
    );
  }
}


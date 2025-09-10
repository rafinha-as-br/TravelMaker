import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/cards/travel_card.dart';
import 'package:travelmakerapp/view/presentation/modules/customLoadingWidget.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/view/presentation/page/homeScreen.dart';

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
        if(asyncSnapshot.connectionState == ConnectionState.done){
          if(!asyncSnapshot.data!.$1.success){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  textError: asyncSnapshot.data!.$1.message!,
                ),
              ).then((_) {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              });
            });

            return const SizedBox.shrink();

          }
          if(asyncSnapshot.data!.$2.isEmpty){
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
                SliverAppBar(),
                SliverToBoxAdapter(
                  child: ListView.builder(
                      itemCount: asyncSnapshot.data?.$2.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: TravelCard(
                              travel: asyncSnapshot.data!.$2[index],
                              index: index
                          ),
                        );
                      }
                  ),
                )
              ],
            ),
          );

        }

        return CustomLoadingWidget();
      }
    );
  }
}


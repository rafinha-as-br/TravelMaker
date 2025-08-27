import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/entitiesProvider.dart';
import 'package:travelmakerapp/interface_adapters/providers/userProvider.dart';
import 'package:travelmakerapp/view/presentation/page/tests.dart';
import 'package:travelmakerapp/view/presentation/page/userConfigScreen.dart';

import '../../../l10n/app_localizations.dart';
import '../modules/buttons/customButton.dart';
import '../modules/homeScreen_title.dart';
import 'createTravelScreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          HomeScreenTitle(),

          SizedBox(height: 50),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child:
            //buttons column
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                //create a travel button
                Row(
                  children: [
                    Expanded(
                        child: SmallButton1(
                            onTap: (){
                              Navigator.pushNamed(context, CreateTravelScreen.routeName);
                            },
                            text: AppLocalizations.of(context)!.createTravel,
                            icon: Icons.add_box_outlined)
                    ),
                  ],
                ),

                //list travels button
                Row(
                  children: [
                    Expanded(
                        child: SmallButton1(
                            onTap: (){},
                            text: AppLocalizations.of(context)!.travelList,
                            icon: Icons.view_timeline_outlined)
                    ),
                  ],
                ),

                //configs button
                Row(
                  children: [
                    Expanded(
                        child: SmallButton1(
                            onTap: (){
                              Navigator.pushNamed(context, UserConfigScreen.routeName);
                            },
                            text: AppLocalizations.of(context)!.userConfig,
                            icon: Icons.settings)
                    ),
                  ],
                ),

                // Tests screen button
                Row(
                  children: [
                    Expanded(
                        child: SmallButton1(
                            onTap: (){
                              Navigator.pushNamed(context, TestScreen.routeName);
                            },
                            text: "Map test",
                            icon: Icons.work_off_outlined)
                    ),
                  ],
                ),

              ],
            )
            ,
          ),



        ],
        )
      ),
    );
  }
}

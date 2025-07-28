import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/button1.dart';
import 'package:travelmakerapp/presentation/modules/homeScreen_title.dart';
import 'package:travelmakerapp/presentation/modules/toggleLanguageButton.dart';
import 'package:travelmakerapp/presentation/page/startScreen.dart';
import 'package:travelmakerapp/presentation/provider/entitiesProvider.dart';
import 'package:travelmakerapp/presentation/provider/userProvider.dart';

import '../../l10n/app_localizations.dart';


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

          SizedBox(height: 100),


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
                        child: Button1(
                            onTap: (){},
                            text: AppLocalizations.of(context)!.createTravel,
                            icon: Icons.add_box_outlined)
                    ),
                  ],
                ),

                //list travels button
                Row(
                  children: [
                    Expanded(
                        child: Button1(
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
                        child: Button1(
                            onTap: (){},
                            text: AppLocalizations.of(context)!.userConfig,
                            icon: Icons.settings)
                    ),
                  ],
                ),
                Togglelanguagebutton(),



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

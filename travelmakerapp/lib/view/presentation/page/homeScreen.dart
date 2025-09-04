import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/page/user_config_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../modules/buttons/customButton.dart';
import '../modules/customLoadingWidget.dart';
import '../modules/homeScreen_title.dart';
import 'createTravelScreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {

    final asp = Provider.of<AppStateProvider>(context);


    return FutureBuilder(
      future: asp.getUser(),
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return CustomLoadingWidget();
        }
        if(asyncSnapshot.connectionState == ConnectionState.done){
          final user = asyncSnapshot.data;
          if (user != null) {
            // need to call loading screen again in case of the user null!
            return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      HomeScreenTitle(user: asyncSnapshot.data!,),

                      SizedBox(height: 50),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                                    child: MediumButton1(
                                        onTap: (){
                                          Navigator.pushNamed(context, CreateTravelScreen.routeName);
                                        },
                                        text: AppLocalizations.of(context)!.createTravel,
                                        icon: Icons.add_box_outlined
                                    )
                                ),
                              ],
                            ),

                            //list travels button
                            Row(
                              children: [
                                Expanded(
                                    child: MediumButton1(
                                        onTap: (){},
                                        text: AppLocalizations.of(context)!.travelList,
                                        icon: Icons.view_timeline_outlined
                                    )
                                ),
                              ],
                            ),

                            //configs button
                            Row(
                              children: [
                                Expanded(
                                    child: MediumButton1(
                                        onTap: (){
                                          Navigator.pushNamed(context, UserConfigScreen.routeName);
                                        },
                                        text: AppLocalizations.of(context)!.userConfig,
                                        icon: Icons.settings
                                    )
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
        return CustomLoadingWidget();
      }
    );
  }
}

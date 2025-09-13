import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../../l10n/app_localizations.dart';
import '../../page/screen_create_stop.dart';
import '../buttons/customButton.dart';
import '../cards/stopCard.dart';
import '../customExpansionTile.dart';
import 'container_customContainer.dart';

class AddStopContainer extends StatelessWidget {
  const AddStopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(widget: Column(
      spacing: 15,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 15,
              children: [
                Icon(Icons.location_on, color: Theme.of(context).primaryColor,),
                Text(AppLocalizations.of(context)!.travelStopTitle, style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).primaryColor,),
            Text(
              AppLocalizations.of(context)!.travelStopText,
              style: Theme.of(context).textTheme.displaySmall,
            )
          ],
        ),

        Customexpansiontile(
          title: AppLocalizations.of(context)!.travelStopsText2,
          initiallyExpanded: true,
          widget: Column(
            children: [
              // stop lists
              ctp.travelStopList.isEmpty ?
              Column(
                children: [
                  SizedBox(height: 20,),
                  Text('Nenhuma parada adicionada', style: Theme.of(context).textTheme.displaySmall,),
                  SizedBox(height: 20,),
                ],
              ) :
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ctp.travelStopList.length,
                  itemBuilder: (context, index){
                    return ListTile(
                        title: StopCard(travelStop: ctp.travelStopList[index], index: index),
                        onTap:(){
                          ctp.setStopEdit(index, context);
                          Navigator.pushNamed(context, StopScreen.routeName);
                        }
                    );

                  }
              ),

              // add stopButton (goes and open another page)
              Row(
                children: [
                  Expanded(
                      child: SmallButton1(
                          onTap: (){
                            Navigator.pushNamed(context, StopScreen.routeName);
                          },
                          text: AppLocalizations.of(context)!.addTravelStop,
                          icon: Icons.flag)
                  )
                ],
              ),

              SizedBox(height: 10,)

            ],
          ),

        ),
      ],
    ));
  }
}

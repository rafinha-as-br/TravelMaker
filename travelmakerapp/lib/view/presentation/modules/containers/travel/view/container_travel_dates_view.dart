import 'package:flutter/material.dart';

import '../../../../helpers/dates/dateFormat.dart';
import '../../../inputDecoration.dart';
import '../../container_customContainer.dart';

/// this widget shows the start and finish date from a travel
class TravelDatesViewContainer extends StatelessWidget {
  ///
  const TravelDatesViewContainer({
    super.key, required this.start, required this.finish
  });

  /// start date
  final DateTime start;

  /// finish date
  final DateTime finish;


  @override
  Widget build(BuildContext context) {
    return CustomContainer1(
        widget: Column(
          spacing: 7,
          children: [
            Column(
              children: [
                Text(
                  'Datas de início e final',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Divider(thickness: 1, color: Theme.of(context).primaryColor,),
              ],
            ),

            Row(
              spacing: 50,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //start
                Column(
                  spacing: 5,
                  children: [
                    Text(
                      'Início',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        readOnly: true,
                        decoration: getInputDecoration(
                            getFormatedDate2(start),
                            context),
                      ),
                    )
                  ],
                ),

                //finish
                Column(
                  spacing: 5,
                  children: [
                    Text(
                      'chegada',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        readOnly: true,
                        decoration: getInputDecoration(
                            getFormatedDate2(finish),
                            context
                        ),
                      ),
                    )
                  ],
                )

              ],
            ),
          ],
        )
    );
  }
}

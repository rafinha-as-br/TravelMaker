import 'package:flutter/material.dart';

import '../../../../helpers/dates/dateFormat.dart';
import '../../../inputDecoration.dart';
import '../../container_customContainer.dart';

/// Container widget that shows the arrival and departure date from a stop
class StopDatesViewContainer extends StatelessWidget {
  ///
  const StopDatesViewContainer({
    super.key, required this.arrival, required this.departure
  });

  /// arrival DateTime
  final DateTime arrival;
  /// arrival DateTime
  final DateTime departure;

  @override
  Widget build(BuildContext context) {
    return CustomContainer1(
        widget: Column(
          spacing: 7,
          children: [
            Column(
              children: [
                Text(
                  'Datas de chegada e saída',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Divider(thickness: 1, color: Theme.of(context).primaryColor,),
              ],
            ),

            Row(
              spacing: 50,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //arrival
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
                            getFormatedDate2(arrival),
                            context),
                      ),
                    )
                  ],
                ),

                //departure
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
                            getFormatedDate2(departure),
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

import 'package:flutter/material.dart';
import 'package:travelmakerapp/services/googleAPI.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

class StopCard extends StatelessWidget {
  const StopCard({super.key});



  final double latitude = -26.9187;
  final double longitude = -49.066;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: getCanvasColor(),
      margin: EdgeInsets.zero,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //background image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))
              ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  child: Image.network(
                    staticMapURL(latitude, longitude),
                  ),
                )
            ),
        
            //bottom
            Container(
              height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Parada 1 - Blumenau, Brasil", style: Theme.of(context).textTheme.displaySmall,),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

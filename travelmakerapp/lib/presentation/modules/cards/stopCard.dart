import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/travelStop.dart';
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

      child: Column(
        children: [
          //background image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
            ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  staticMapURL(latitude, longitude),
                  height: 250,
                ),
              )
          ),

          //bottom
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: getCanvasColor()
            ),
            child: Text("teste"),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/services/googleAPI.dart';
class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  static const routeName = '/TestScreen';

  double latitude = -26.9187;
  double longitude = -49.066;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Column(
          children: [
            /*
            Button1(onTap: (){
              apiGET();
            }, text: "get map test", icon: Icons.get_app)

           */



            Image.network(staticMapURL(latitude, longitude))

          ],
        ),
      ),
    );
  }
}

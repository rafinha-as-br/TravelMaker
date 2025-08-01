import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

import '../../../usecase/Themes/appThemes.dart';
import '../../provider/userProvider.dart';

class Button1 extends StatelessWidget {
  const Button1({super.key, required this.onTap, required this.text, required this.icon});

  final VoidCallback onTap;
  final String text;
  final IconData icon;



  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: getCanvasColor(),
              border: Border.all(
                width: 1.5,
                color: getPrimaryColor(),
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(icon, color: getPrimaryColor(),),
                Text(text, style: Theme.of(context).textTheme.displaySmall),
              ],)
        )
    );
  }
}

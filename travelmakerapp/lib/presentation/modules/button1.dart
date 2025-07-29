import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../usecase/appThemes.dart';
import '../provider/userProvider.dart';

class Button1 extends StatelessWidget {
  const Button1({super.key, required this.onTap, required this.text, required this.icon});

  final VoidCallback onTap;
  final String text;
  final IconData icon;



  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);


    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: userProvider.darkTheme ? AppThemes.darkTheme.canvasColor : AppThemes.lightTheme.canvasColor,
              border: Border.all(
                width: 1.5,
                color: userProvider.darkTheme ? Color(0xFFF9F3EF): Color(0xFF3A6B8A),
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(width: 10,),
                Icon(icon, color: userProvider.darkTheme ? Color(0xFFF9F3EF) : Color(0xFF3A6B8A),),
                Text(text, style: Theme.of(context).textTheme.displaySmall),
              ],)
        )
    );
  }
}

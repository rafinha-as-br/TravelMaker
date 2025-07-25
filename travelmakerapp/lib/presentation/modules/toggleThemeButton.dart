import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/provider/userProvider.dart';
import 'package:travelmakerapp/usecase/appThemes.dart';

class Togglethemebutton extends StatelessWidget {
  const Togglethemebutton({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){
        userProvider.toggleTheme(!userProvider.darkTheme);
      },
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
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Text(userProvider.darkTheme ? 'Tema escuro': 'Tema claro',),
                Icon(userProvider.darkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: userProvider.darkTheme ? Color(0xFFF9F3EF) : Color(0xFF3A6B8A),)
              ],)
        )
    );
  }
}

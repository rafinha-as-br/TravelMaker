import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/userProvider.dart';

class Togglelanguagebutton extends StatelessWidget {
  const Togglelanguagebutton({super.key});


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onTap: (){

      },
      child: Container(
        child: Row(
          children: [

          ],
        ),
      ),
    );
  }
}

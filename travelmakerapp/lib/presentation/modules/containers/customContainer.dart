import 'package:flutter/material.dart';

import '../../../Themes/getTheme.dart';

class CustomContainer1 extends StatelessWidget {
  const CustomContainer1({super.key, required this.widget});

  final Widget widget;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: getPrimaryColor(), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 15),
        child: widget,
      ),
    );
  }
}

class CustomSubContainer1 extends StatelessWidget {
  const CustomSubContainer1({super.key, required this.text1, required this.text2, required this.icon});

  final String text1;
  final String text2;
  final IconData icon;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 15,
          children: [
            Icon(icon, color: getPrimaryColor(),),
            Text(text1, style: Theme.of(context).textTheme.displayMedium,),
          ],
        ),
        Divider(thickness: 1, color: getPrimaryColor(),),
        Text(text2, style: Theme.of(context).textTheme.displaySmall,)
      ],
    );
  }
}


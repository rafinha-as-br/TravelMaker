import 'package:flutter/material.dart';

import '../../usecase/Themes/getTheme.dart';

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
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 35, vertical: 30),
        child: widget,
      ),
    );
  }
}

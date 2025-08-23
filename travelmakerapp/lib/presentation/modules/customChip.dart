import 'package:flutter/material.dart';
import '../../Themes/getTheme.dart';

Chip ExperienseChip(String experiense, bool isSelected, BuildContext context){
  return Chip(
    label: Text(experiense, style: Theme.of(context).textTheme.displaySmall,),
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: getPrimaryColor(),
        width: 2
      )
    ),
  );
}
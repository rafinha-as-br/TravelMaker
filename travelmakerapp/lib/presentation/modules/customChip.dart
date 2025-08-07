import 'package:flutter/material.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

Chip experienseChip(String experiense){
  return Chip(
    label: Text(experiense),
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: getPrimaryColor(),
        width: 2
      )
    ),
  );
}
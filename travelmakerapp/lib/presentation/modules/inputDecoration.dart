// This function return an inputDecoration to any TextFormField, receving the labelText

import 'package:flutter/material.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

InputDecoration getInputDecoration(String string, BuildContext context){
  InputDecoration inputDecoration = InputDecoration(

    hintText: string,
    hintStyle: Theme.of(context).textTheme.displaySmall,
    fillColor: getCanvasColor(),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1.5,
          color: getPrimaryColor()
      ),
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1.5,
            color: getPrimaryColor()
        ),
        borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    focusColor: getPrimaryColor(),
    labelStyle: TextStyle(
      color: getPrimaryColor(),
    ),
  );

  return inputDecoration;
}
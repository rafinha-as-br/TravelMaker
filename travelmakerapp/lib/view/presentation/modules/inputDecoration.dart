// This function return an inputDecoration to any TextFormField, receving the labelText
import 'package:flutter/material.dart';

  
InputDecoration getInputDecoration(String string, BuildContext context){
  InputDecoration inputDecoration = InputDecoration(

    hintText: string,
    hintStyle: Theme.of(context).textTheme.displaySmall,
    fillColor:  Theme.of(context).canvasColor,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).primaryColor
      ),
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1.5,
            color: Theme.of(context).primaryColor
        ),
        borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    focusColor: Theme.of(context).primaryColor,
    labelStyle: TextStyle(
      color: Theme.of(context).primaryColor,
    ),
    


    errorStyle: TextStyle(
      color: Theme.of(context).primaryColor,
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1.5,
            color: Theme.of(context).primaryColor
        ),
        borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1.5,
            color: Theme.of(context).primaryColor
        ),
        borderRadius: BorderRadius.all(Radius.circular(15))
    ),

  );

  return inputDecoration;
}
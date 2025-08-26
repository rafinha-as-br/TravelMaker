import 'package:flutter/material.dart';

Widget dateDisplayer(DateTime? date1, DateTime? date2, BuildContext context){
  if(date1 == null || date2 == null){
    return Text("Selecione as datas de início e fim!", style: Theme.of(context).textTheme.displaySmall,);
  }
  int timeSpent = date2.difference(date1).inDays;
  return Text('$timeSpent dias', style: Theme.of(context).textTheme.displayLarge,);
}
import 'package:flutter/material.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

class Customexpansiontile extends StatelessWidget {
  const Customexpansiontile({
    super.key, required this.title, required this.widget, required this.initiallyExpanded
  });

  final String title;
  final Widget widget;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getCanvasColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          backgroundColor: getCanvasColor(),
          iconColor: getPrimaryColor(),
          collapsedIconColor: getPrimaryColor(),

          title: Text(title, style: Theme.of(context).textTheme.displaySmall,),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: widget,
            )
          ]),
    );
  }
}

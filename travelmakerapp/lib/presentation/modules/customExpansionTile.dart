import 'package:flutter/material.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

class Customexpansiontile extends StatelessWidget {
  const Customexpansiontile({
    super.key, required this.title, required this.widget
  });

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getCanvasColor(),
      child: ExpansionTile(
          backgroundColor: getCanvasColor(),
          iconColor: getPrimaryColor(),
          collapsedIconColor: getPrimaryColor(),
          title: Text(title, style: Theme.of(context).textTheme.displaySmall,),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                width: 100,
                height: 200,
                child: widget,
              ),
            )
          ]),
    );
  }
}

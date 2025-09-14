import 'package:flutter/material.dart';


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
      color:  Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          backgroundColor:  Theme.of(context).canvasColor,
          iconColor: Theme.of(context).primaryColor,
          collapsedIconColor: Theme.of(context).primaryColor,

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

class Customexpansiontile2 extends StatelessWidget {
  const Customexpansiontile2({
    super.key, required this.title, required this.widget, required this.initiallyExpanded
  });

  final String title;
  final Widget widget;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
            style: BorderStyle.solid

        ),

        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
              style: BorderStyle.solid

            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          backgroundColor:  Theme.of(context).colorScheme.surface,
          iconColor: Theme.of(context).primaryColor,
          collapsedIconColor: Theme.of(context).colorScheme.primary,

          title: Text(title, style: Theme.of(context).textTheme.displayMedium,),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: widget,
            )
          ]),
    );
  }
}

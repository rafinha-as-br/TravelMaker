import 'package:flutter/material.dart';

 import '../containers/customContainer.dart';


class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.title, required this.widget, required this.onClose});
  final String title;
  final Widget widget;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:  Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: CustomContainer1(
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // close button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                    padding: EdgeInsetsGeometry.zero,
                    constraints: BoxConstraints(),
                  ),
                  Text(title, style: Theme.of(context).textTheme.displayMedium,)
                ],
              ),
              Divider(
                thickness: 1.5,
                color: Theme.of(context).primaryColor,
              ),

              widget

            ],
          ),
        ),
      ),
    );
  }
}

//more used for errors dialogs, doesn't have close button!
class CustomDialog2 extends StatelessWidget {
  const CustomDialog2({super.key, required this.title, required this.widget, required this.icon});
  final String title;
  final Widget widget;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      backgroundColor:  Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: CustomContainer1(
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: Theme.of(context).primaryColor, size: 25,),
                  Text(title, style: Theme.of(context).textTheme.displayMedium,)
                ],
              ),
              Divider(
                thickness: 1.2,
                color: Theme.of(context).primaryColor,
              ),

              widget

            ],
          ),
        ),
      ),
    );
  }
}

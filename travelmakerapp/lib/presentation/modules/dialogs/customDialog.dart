import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/containers/customContainer.dart';

import '../../../Themes/getTheme.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.title, required this.widget, required this.onClose});
  final String title;
  final Widget widget;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: getCanvasColor(),
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
                      color: getPrimaryColor(),
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
                color: getPrimaryColor(),
              ),

              widget

            ],
          ),
        ),
      ),
    );
  }
}

//more used for errors dialogs
class CustomDialog2 extends StatelessWidget {
  const CustomDialog2({super.key, required this.title, required this.widget, required this.icon});
  final String title;
  final Widget widget;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: getCanvasColor(),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: getPrimaryColor(), size: 25,),
                  Text(title, style: Theme.of(context).textTheme.displaySmall,)
                ],
              ),
              Divider(
                thickness: 1.2,
                color: getPrimaryColor(),
              ),

              widget

            ],
          ),
        ),
      ),
    );
  }
}

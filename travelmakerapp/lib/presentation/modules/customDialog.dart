import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/customContainer.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.title, required this.widget});
  final String title;
  final Widget widget;

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
            children: [
              // close button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 15,
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
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

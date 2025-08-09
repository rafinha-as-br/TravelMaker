import 'package:flutter/material.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

import 'inputDecoration.dart';

class CustomTextFormField1 extends StatelessWidget {
  const CustomTextFormField1({
    super.key,
    required this.title,
    required this.controller,
    required this.validator
  });

  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: getInputDecoration(title, context),
        style: Theme.of(context).textTheme.displaySmall,
        cursorColor: getPrimaryColor(),
        keyboardType: TextInputType.text,
        controller: controller,
        validator: validator,
        errorBuilder: (context, errorText) {
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';

import '../../l10n/app_localizations.dart';
import '../../services/googleAPI.dart';
import 'inputDecoration.dart';

class CustomTextFormField1 extends StatelessWidget {
  const CustomTextFormField1({
    super.key,
    required this.title,
    required this.controller,
    required this.formFieldKey
  });

  final String title;
  final TextEditingController controller;
  final GlobalKey<FormFieldState> formFieldKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.center,
        key: formFieldKey,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: getInputDecoration(title, context),
        style: Theme.of(context).textTheme.displaySmall,
        cursorColor: getPrimaryColor(),
        keyboardType: TextInputType.text,
        controller: controller,
      ),
    );
  }
}

// CustomTextFormField to TypeAheadField
class CustomTextFormField2 extends StatelessWidget {
  const CustomTextFormField2({super.key, required this.controller, required this.formFieldKey, required this.onSelect});

  final TextEditingController controller;
  final GlobalKey<FormFieldState> formFieldKey;
  final Function(String) onSelect;


  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Map<String, dynamic>>(

      // set false because the widget is already forcing hiding inside the onSelected function (both activated gets a double focus bug)
      hideOnSelect: false,

      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) return [];
        return await fetchCitySuggestions(pattern);
      },
      emptyBuilder: (context){
        return SizedBox.shrink();
      },
      decorationBuilder: (context, child) {
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(15),
          color: getCanvasColor(),
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: child
          ),
        );
      },
      builder: (context, internalController, focusNode) {
        internalController.text=controller.text;

        internalController.addListener(() {
          if (controller.text != internalController.text) {
            controller.text=internalController.text;
          }
        });

        focusNode.addListener(() {
          if (focusNode.hasFocus) {
            Scrollable.ensureVisible(
              formFieldKey.currentContext!,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: 0.35,
            );
          }
        });


        return TextField(
          cursorColor: getPrimaryColor(),
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
          controller: internalController,
          key: formFieldKey,
          focusNode: focusNode,
          decoration: getInputDecoration(AppLocalizations.of(context)!.city, context),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          tileColor: getCanvasColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
          title: Text(suggestion['description'], style: Theme.of(context).textTheme.displaySmall,),
        );
      },
      onSelected: (suggestion) async {
        print('Cidade escolhida: ${suggestion['description']}');
        print('Lat: ${suggestion['lat']}, Lng: ${suggestion['lng']}');
        onSelect(suggestion['description']);

        //force the widget to hide the suggestions
        FocusScope.of(context).unfocus();

      },
    );
  }
}


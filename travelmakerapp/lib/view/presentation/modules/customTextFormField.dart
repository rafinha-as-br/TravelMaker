import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
  import '../../../l10n/app_localizations.dart';
import '../../services/googleAPI.dart';
import 'inputDecoration.dart';

class CustomTextFormField1 extends StatelessWidget {
  const CustomTextFormField1({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: getInputDecoration(title, context),
        style: Theme.of(context).textTheme.displaySmall,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: TextInputType.text,
        controller: controller,
      ),
    );
  }
}

// CustomTextFormField to TypeAheadField (used on destination textFields)
class CustomTextFormField2 extends StatelessWidget {
  CustomTextFormField2({super.key, required this.controller, required this.onSelect});

  final TextEditingController controller;
  final fieldKey = GlobalKey();
  final Function(Map<String, dynamic>) onSelect;


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
          color:  Theme.of(context).canvasColor,
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (fieldKey.currentContext != null) {
                Scrollable.ensureVisible(
                  fieldKey.currentContext!,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: 0.35,
                );
              }
            });
          }
        });


        return TextField(
          cursorColor: Theme.of(context).primaryColor,
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
          controller: internalController,
          key: fieldKey,
          focusNode: focusNode,
          decoration: getInputDecoration(AppLocalizations.of(context)!.city, context),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          tileColor:  Theme.of(context).canvasColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
          title: Text(suggestion['description'], style: Theme.of(context).textTheme.displaySmall,),
        );
      },
      onSelected: (suggestion) async {
        // calls the function from outside
        onSelect(suggestion);
        //force the widget to hide the suggestions
        FocusScope.of(context).unfocus();
      },
    );
  }
}

//used for description and person stop comments
class CustomTextFormField3 extends StatelessWidget {
  const CustomTextFormField3({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextFormField(
        textAlign: TextAlign.start,
        minLines: 8,
        maxLines: 8,
        textAlignVertical: TextAlignVertical.top,
        decoration: getInputDecoration(title, context),
        style: Theme.of(context).textTheme.displaySmall,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: TextInputType.text,
        controller: controller,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../../../Themes/getTheme.dart';
import '../../../l10n/app_localizations.dart';
import 'buttons/customButton.dart';
import 'inputDecoration.dart';

class userDialog extends StatelessWidget {
  userDialog({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      backgroundColor: getCanvasColor(),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: getPrimaryColor(),
                  ),
                ),
                SizedBox(width: 50,),
                Text('Editando usuário')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          spacing: 25,
                          children: [
                            Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                // name TextFormField
                                Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: getInputDecoration(AppLocalizations.of(context)!.yourName, context),
                                    style: Theme.of(context).textTheme.displaySmall,
                                    cursorColor: getPrimaryColor(),
                                    keyboardType: TextInputType.text,
                                    controller: nameController,
                                    validator: (value){
                                      if(value==null){
                                        return AppLocalizations.of(context)!.errorPersonNameEmpty;
                                      }
                                      if(value.length<2){
                                        return AppLocalizations.of(context)!.errorPersonNameShort;
                                      }
                                      return null;
                                    },
                                  ),

                                ),

                                // age TextFormField
                                Container(
                                  width: 90,
                                  height: 50,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: getInputDecoration(AppLocalizations.of(context)!.yourAge, context),
                                    cursorColor: getPrimaryColor(),
                                    style: Theme.of(context).textTheme.displaySmall,
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {

                                      final number = int.tryParse(value!);

                                      if (number! <= 0) {
                                        return AppLocalizations.of(context)!.errorPersonAgeInvalid;
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SmallButton2(
                                onTap: () {
                                  if(_formKey.currentState!.validate()){

                                  }
                                },
                                text:  AppLocalizations.of(context)!.continuee, icon: Icons.account_circle_outlined)
                          ],
                        )
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

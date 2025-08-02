import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/presentation/modules/buttons/customButton.dart';
import 'package:travelmakerapp/presentation/modules/inputDecoration.dart';
import 'package:travelmakerapp/usecase/Themes/getTheme.dart';
import 'package:travelmakerapp/usecase/appLoader.dart';

import '../../entities/user.dart';
import '../../l10n/app_localizations.dart';
import '../page/homeScreen.dart';
import '../provider/userProvider.dart';

class UserForm extends StatelessWidget {
  UserForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Form(
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
                        return AppLocalizations.of(context)!.yourNameError1;
                      }
                      if(value.length<2){
                        return AppLocalizations.of(context)!.yourNameError2;
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
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.yourAgeError3;
                      }

                      final number = int.tryParse(value);
                      if (number == null) {
                        return AppLocalizations.of(context)!.yourAgeError1;
                      }

                      if (number < 0) {
                        return AppLocalizations.of(context)!.yourAgeError2;
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
            Button1(
              onTap: () {
                if(_formKey.currentState!.validate()){
                  userProvider.createUser(nameController.text, int.parse(ageController.text), true);
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
            }, text:  AppLocalizations.of(context)!.continuee, icon: Icons.account_circle_outlined)
          ],
        )
      ),
    );
  }
}

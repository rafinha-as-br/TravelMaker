import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/page/loading_screen.dart';
  import '../../../entities/validator.dart';
import '../../../l10n/app_localizations.dart';
import '../page/homeScreen.dart';
import 'buttons/customButton.dart';
import 'dialogs/errorDialog.dart';
import 'inputDecoration.dart';

class UserForm extends StatelessWidget {
  UserForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

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
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                    controller: appState.nameController,
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
                    cursorColor: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.displaySmall,
                    controller: appState.ageController,
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
            SmallButton1(
              onTap: () async {

                //creating the user
                Validator createUser = await appState.createUser();
                if (!context.mounted) return; // to clear the (Don't use 'BuildContext's across async gaps.)
                if(!createUser.success){
                  showDialog(
                      context: context,
                      builder: (context) => ErrorDialog(textError: createUser.message!)
                  );
                } else{
                  Navigator.pushNamed(context, AppLoaderScreen.routeName);
                }

              }, text:  AppLocalizations.of(context)!.continuee, icon: Icons.account_circle_outlined)
          ],
        )
      ),
    );
  }
}

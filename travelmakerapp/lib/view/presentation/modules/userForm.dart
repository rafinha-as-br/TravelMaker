import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';
import 'package:travelmakerapp/view/presentation/modules/customTextFormField.dart';
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
  final GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> ageKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
          children: [
            Row(
              spacing: 3,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // name TextFormField
                Container(
                  width: 150,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: CustomTextFormField1(
                        title: 'Seu nome',
                        controller: appState.nameController,
                    )
                  ),

                ),

                // age TextFormField
                Container(
                  width: 120,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Container(
                      width: 90,
                      height: 50,
                      child: CustomTextFormField1(
                          title: AppLocalizations.of(context)!.yourAge,
                          controller: appState.ageController,
                      )
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: MediumButton3(
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

                }, text:  AppLocalizations.of(context)!.continuee, icon: Icons.account_circle_outlined),
            )
          ],
        )
      ),
    );
  }
}



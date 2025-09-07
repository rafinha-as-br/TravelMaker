import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/confirmBackDialog.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/customDialog.dart';
import 'package:travelmakerapp/view/presentation/modules/dialogs/errorDialog.dart';
import 'package:travelmakerapp/view/presentation/page/homeScreen.dart';
  import '../../../../entities/user.dart';
import '../../../../interface_adapters/providers/AppStateProvider.dart';
import '../../../../l10n/app_localizations.dart';
import '../buttons/customButton.dart';
import '../customTextFormField.dart';

class UserDialog extends StatelessWidget {
  UserDialog({super.key, required this.user});
  final User user;

  final GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> ageKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final asp = Provider.of<AppStateProvider>(context);

    return CustomDialog(
        title: "Editando usuário",
        widget: Column(
          children: [

            // person info
            Column(
              spacing: 15,
              children: [
                SizedBox(height: 1),
                //picture
                InkWell(
                  onTap: () async{
                    await asp.selectProfilePicture();
                  },
                  child: Column(
                    children: [

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: asp.profilePicture == null
                                ? null
                                : FileImage(
                              File(asp.profilePicture.toString()),
                            ),
                            child: user.profilePicturePath == null
                                ? Icon(
                              Icons.person,
                              size: 45,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.profilePicturePath == null
                            ? AppLocalizations.of(context)!.addPhoto
                            : AppLocalizations.of(context)!.replacePhoto,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

            Container(
              width: 200,
              child: Divider(thickness: 1.4, color: Theme.of(context).primaryColor),
            ),

            // form
            Column(
              spacing: 15,
              children: [

                Row(
                  spacing: 15,
                  children: [
                    //name
                    Expanded(
                      child: CustomTextFormField1(
                        title: AppLocalizations.of(context)!.name,
                        controller: asp.editNameController,
                      ),
                    ),

                    //age
                    Expanded(
                      child: CustomTextFormField1(
                        title: AppLocalizations.of(context)!.age,
                        controller: asp.editAgeController,

                      ),
                    ),


                  ],
                ),

                //save button
                MediumButton2(
                  onTap: () async{
                    final updateUser = await asp.updateUser();
                    if(!updateUser.success && context.mounted){
                      showDialog(
                          context: context,
                          builder: (context) => ErrorDialog(textError: updateUser.message!)
                      );
                    } else{
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }

                  },
                  text: AppLocalizations.of(context)!.saveAlterations,
                  icon: Icons.abc,
                ),
              ],
            ),

            // save button
          ],
        ),
        onClose: () async{
          if(asp.editMode == true){
            final bool? answer = await showDialog(
                context: context,
                builder: (context) => ConfirmbackDialog()
            );
            if(answer == true && context.mounted){
              asp.clearControllers();
              Navigator.of(context).pop();
            }
          }


        }
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';

import '../../l10n/app_localizations.dart';
import '../../usecase/Themes/getTheme.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.personsList, required this.editOnTap, required this.removeOnTap});

  final List<Person> personsList;
  final void Function(int index) editOnTap;
  final void Function(int index) removeOnTap;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: personsList.length,
      itemBuilder: (context, index) {

        return Container(
          height: 35,
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: getBackgroundColor(),
                    backgroundImage: personsList[index].profilePicture == null ? null : FileImage(File(personsList[index].profilePicture!),),
                    child: personsList[index].profilePicture == null ? Icon(Icons.person, size: 10, color: getPrimaryColor(),) : null,
                  ),

                  SizedBox(width: 5,),
                  //name
                  Text(
                    "${personsList[index].name}, ",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  //age
                  Text(
                    "${personsList[index].age.toString()}"
                        " ${AppLocalizations.of(context)!.years}",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),

              //actions buttons (the first on is always the user
              if(index != 0) ...[
                Row(
                  children: [
                    VerticalDivider(thickness: 1, color: getPrimaryColor(),),

                    // edit person button
                    IconButton(
                      onPressed: () => editOnTap(index),
                      icon: Icon(
                        Icons.edit,
                        color: getPrimaryColor(),
                        size: 15,
                      ),
                      padding: EdgeInsetsGeometry.zero,
                      constraints: BoxConstraints(),
                    ),
                    IconButton(
                      onPressed: () => removeOnTap(index),
                      icon: Icon(
                        Icons.delete,
                        color: getPrimaryColor(),
                        size: 15,
                      ),
                      padding: EdgeInsetsGeometry.zero,
                      constraints: BoxConstraints(),

                    ),
                  ],
                )
              ]

            ],
          ),
        );
      },
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/person.dart';

import '../../../entities/comment.dart';
import '../../../l10n/app_localizations.dart';
import 'containers/container_customContainer.dart';

///used for travelParticipants view
class CustomListView1 extends StatelessWidget {
  ///used for travelParticipants view
  const CustomListView1({super.key, required this.personsList, required this.editOnTap, required this.removeOnTap});

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
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: personsList[index].profilePicture == null ? null : FileImage(File(personsList[index].profilePicture!),),
                    child: personsList[index].profilePicture == null ? Icon(Icons.person, size: 10, color: Theme.of(context).primaryColor,) : null,
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
                    VerticalDivider(thickness: 1, color: Theme.of(context).primaryColor,),

                    // edit person button
                    IconButton(
                      onPressed: () => editOnTap(index),
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      padding: EdgeInsetsGeometry.zero,
                      constraints: BoxConstraints(),
                    ),

                    //remove person button
                    IconButton(
                      onPressed: () => removeOnTap(index),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
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

// used for stop comments view
class CustomListView2 extends StatelessWidget {
  const CustomListView2({
    super.key, required this.comments, required this.editOnTap, required this.removeOnTap
  });

  final List<Comment> comments;
  final void Function(int index) editOnTap;
  final void Function(int index) removeOnTap;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, index){

          return CustomContainer1(
              widget: Column(
                children: [

                  //person
                  Row(
                    spacing:15,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        backgroundImage: comments[index].person.profilePicture == null ? null : FileImage(File(comments[index].person.profilePicture!),),
                        child:  comments[index].person.profilePicture == null ? Icon(Icons.person, size: 10, color: Theme.of(context).primaryColor,) : null,
                      ),
                      SizedBox(width: 5,),
                      //name
                      Text(
                        "${comments[index].person.name}, ",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      //age
                      Text(
                        "${comments[index].person.age.toString()}"
                            " ${AppLocalizations.of(context)!.years}",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),

                      //actions buttons
                      Row(
                        children: [
                          VerticalDivider(thickness: 1, color: Theme.of(context).primaryColor,),

                          // edit person button
                          IconButton(
                            onPressed: () => editOnTap(index),
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                              size: 15,
                            ),
                            padding: EdgeInsetsGeometry.zero,
                            constraints: BoxConstraints(),
                          ),

                          //remove person button
                          IconButton(
                            onPressed: () => removeOnTap(index),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).primaryColor,
                              size: 15,
                            ),
                            padding: EdgeInsetsGeometry.zero,
                            constraints: BoxConstraints(),

                          ),
                        ],
                      )

                    ],
                  ),

                  //person's comment
                  CustomContainer1(
                      widget: Text(comments[index].text, style: Theme.of(context).textTheme.displaySmall,)
                  )

                ],
              )
          );
        }
    );
  }
}


import 'package:flutter/material.dart';

import '../../../../entities/comment.dart';
import '../../../../l10n/app_localizations.dart';
import '../circleAvatars/circle_avatar_person.dart';
import '../containers/container_customContainer.dart';

/// this widget is used to show, edit and remove
/// the comments from a comment list
class StopCommentsListView extends StatelessWidget {
  ///
  const StopCommentsListView({
    super.key, required this.comments,
    required this.editAction, required this.removeAction
  });

  /// the comments list that
  final List<Comment> comments;

  /// the edit action that happens when the user presses the edit icon
  final void Function(int index) editAction;

  /// the remove action that happens when the user presses the remove icon
  final void Function(int index) removeAction;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, index){
          final comment = comments[index];

          return CustomContainer1(
              widget: Column(
                children: [

                  //person
                  Row(
                    spacing:15,
                    children: [
                      PersonCircleAvatar(person: comment.person),
                      SizedBox(width: 5,),
                      //name
                      Text(
                        '${comment.person.name}, ',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      //age
                      Text(
                        '${comment.person.age.toString()}'
                        ' ${AppLocalizations.of(context)!.years}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),

                      //actions buttons
                      Row(
                        children: [
                          VerticalDivider(
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                          ),

                          // edit person button
                          IconButton(
                            onPressed: () => editAction(index),
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
                            onPressed: () => removeAction(index),
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
                    widget: Text(
                      comment.text,
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ),

                ],
              )
          );
        }
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../entities/person.dart';
/// this widget shows a personPicture or a empty person icon in place
class PersonCircleAvatar extends StatelessWidget {
  ///
  const PersonCircleAvatar({super.key, required this.person});

  /// the person that is going to show the profile picture
  final Person person;


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundImage: person.profilePicture == null ?
      null : FileImage(File(person.profilePicture!),),
      child: person.profilePicture == null ?
      Icon(
        Icons.person,
        size: 10,
        color: Theme.of(context).primaryColor,
      ) :
      null,
    );
  }
}

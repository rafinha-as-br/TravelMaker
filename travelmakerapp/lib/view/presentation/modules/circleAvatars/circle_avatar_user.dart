import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../entities/user.dart';

/// this widget shows the userPicture or a empty person icon in place
class UserCircleAvatar extends StatelessWidget {
  ///
  const UserCircleAvatar({super.key, required this.user});

  /// the user that is going to show the profile picture
  final User user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[300],
      backgroundImage: user.profilePicturePath == null
          ? null
          : FileImage(
        File(user.profilePicturePath!),
      ),
      child: user.profilePicturePath == null
          ? Icon(
        Icons.person,
        size: 45,
        color: Theme.of(context).scaffoldBackgroundColor,
      )
          : null,
    );
  }
}

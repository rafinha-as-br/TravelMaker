
import 'package:flutter/cupertino.dart';

/// experience table saves only the ID, the app relates the name and icon by map!!

class Experience {

  //from database
  int experienceID;

  //relating the id to the name and icon...
  String name;
  Icon icon;

  Experience(this.experienceID, this.name, this.icon);
}



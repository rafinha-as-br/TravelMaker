
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/experience.dart';

IconData getExperienceIcon(Experiences experience){
  switch(experience){
    case Experiences.cultural:
      return Icons.theater_comedy;
    case Experiences.gastronomic:
      return Icons.restaurant_menu;
    case Experiences.historic:
      return Icons.museum_outlined;
    case Experiences.nature:
      return Icons.park_outlined;
    case Experiences.religious:
      return Icons.synagogue;
    case Experiences.tour:
      return Icons.luggage;
  }
}
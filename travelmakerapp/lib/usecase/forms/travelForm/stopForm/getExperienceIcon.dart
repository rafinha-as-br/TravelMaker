
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/experience.dart';

IconData getExperienceIcon(ExperiencesList experience){
  switch(experience){
    case ExperiencesList.cultural:
      return Icons.theater_comedy;
    case ExperiencesList.gastronomic:
      return Icons.restaurant_menu;
    case ExperiencesList.historic:
      return Icons.museum_outlined;
    case ExperiencesList.nature:
      return Icons.park_outlined;
    case ExperiencesList.religious:
      return Icons.synagogue;
    case ExperiencesList.tour:
      return Icons.luggage;
  }
}
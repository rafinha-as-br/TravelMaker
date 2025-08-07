import 'package:flutter/material.dart';
import 'package:travelmakerapp/presentation/modules/customExpansionTile.dart';

import '../../entities/experience.dart';
class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  static const routeName = '/TestScreen';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 55),
        child: Wrap(
          spacing: 8,
          runSpacing: 12,
          children: Experiences.values.map((experience) {
            return Chip(
              label: Text(experience.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}

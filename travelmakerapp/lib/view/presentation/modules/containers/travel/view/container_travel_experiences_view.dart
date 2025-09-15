import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../../chips/customChip.dart';
import '../../container_customContainer.dart';

/// this widget returns a container that shows the experiences based on a
/// experience list
class TravelExperiencesViewContainer extends StatelessWidget {
  ///
  const TravelExperiencesViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final tvp = Provider.of<TravelViewProvider>(context);

    final experienceList = tvp.travel.experiencesList;


    return CustomContainer1(
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text(
                'experiências desta viagem',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 0
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 1,
                  children: experienceList.map((experience) {
                    final isSelected = experienceList.contains(experience);
                    return ExperienseChip(
                        experience.name, isSelected, context
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        )
    );
  }
}

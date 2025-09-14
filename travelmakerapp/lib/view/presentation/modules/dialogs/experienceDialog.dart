import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/view/presentation/helpers/getExperienceIcon.dart';
 import '../../../../interface_adapters/providers/provider_create_travel.dart';
import 'customDialog.dart';

class ExperienceDialog extends StatelessWidget {
  final CreateTravelProvider createTravelProvider;
  const ExperienceDialog({super.key, required this.createTravelProvider});

  @override
  Widget build(BuildContext context) {


    return CustomDialog(
        title: "Adicionar experiência",
        onClose: (){
          Navigator.of(context).pop();
        },
        widget: Column(
          spacing: 10,
          children: [
            Text(
              "Selecione qual experiência você gostaria de ter nesta parada",
              style: Theme.of(context).textTheme.displaySmall,),
            SizedBox(
              width: 400,
              height: 400,
              child: ListView.builder(
                itemCount: Experiences.values.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  final experience = Experiences.values[index];
                  bool isSelected = createTravelProvider.experiencesList.contains(experience);

                  return Container(
                    height: 55,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      selected: isSelected,
                      tileColor: Theme.of(context).scaffoldBackgroundColor,
                      selectedTileColor: Colors.green[500],
                      onTap: (){
                        createTravelProvider.updateExperienceList(experience);
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 15,
                        children: [
                          //icon
                          Icon(getExperienceIcon(experience), color: Theme.of(context).primaryColor,),
                          Text(experience.name, style: Theme.of(context).textTheme.displaySmall,)
                        ],
                      )
                    ),
                  );
                },
              ),
            )
          ],
        ),
    );
  }
}

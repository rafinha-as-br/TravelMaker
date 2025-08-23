import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/entities/experience.dart';
import 'package:travelmakerapp/presentation/modules/dialogs/customDialog.dart';
import 'package:travelmakerapp/usecase/forms/travelForm/stopForm/getExperienceIcon.dart';

import '../../../Themes/getTheme.dart';
import '../../provider/createTravelProvider.dart';

class ExperienceDialog extends StatelessWidget {
  const ExperienceDialog({super.key});

  @override
  Widget build(BuildContext context) {

    final createTravelProvider = Provider.of<CreateTravelProvider>(context);


    return CustomDialog(
        title: "Adicionar experiência",
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
                itemCount: ExperiencesList.values.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  final experience = ExperiencesList.values[index];
                  bool isSelected = createTravelProvider.experiencesList.contains(experience);

                  return Container(
                    height: 55,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      selected: isSelected,
                      tileColor: getBackgroundColor(),
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
                          Icon(getExperienceIcon(experience), color: getPrimaryColor(),),
                          Text(experience.name, style: Theme.of(context).textTheme.displaySmall,)
                        ],
                      )
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

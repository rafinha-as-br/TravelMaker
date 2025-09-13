import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_customContainer.dart';
import 'package:travelmakerapp/view/presentation/modules/listViews/list_view_editable_travel_participants.dart';
import '../../../../interface_adapters/providers/provider_create_travel.dart';
import '../listViews/list_view_travel_stop_comments.dart';

class CommentsDisplayerContainer extends StatelessWidget {
  const CommentsDisplayerContainer({super.key});


  @override
  Widget build(BuildContext context) {
    final ctp = Provider.of<CreateTravelProvider>(context);

    return CustomContainer1(
        widget: Column(
          children: [

            //header
            CustomSubContainer1(
                text1: 'Comentários',
                text2: "Edite ou remova qualquer comentário feito pelos participantes",
                icon: Icons.comment
            ),

            //body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StopCommentsListView(
                  comments: ctp.sfc.comments,
                  editAction: (index){
                    //todo
                  },
                  removeAction: (index){
                    //todo
                  })
            )

          ],
        )
    );
  }
}


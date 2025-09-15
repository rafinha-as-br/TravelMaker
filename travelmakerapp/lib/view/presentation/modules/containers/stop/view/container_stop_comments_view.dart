import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/view/presentation/modules/containers/container_customContainer.dart';
import 'package:travelmakerapp/view/presentation/modules/listViews/list_view_editable_travel_participants.dart';
import '../../../../../../entities/comment.dart';
import '../../../../../../interface_adapters/providers/provider_create_travel.dart';
import '../../../../../../interface_adapters/providers/provider_travel_view.dart';
import '../../../listViews/list_view_travel_stop_comments.dart';

/// this widget returns the comments from a list
class StopCommentsContainer extends StatelessWidget {

  ///
  const StopCommentsContainer({super.key, required this.comments});

  /// comments list
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {


    return StopCommentsListView(
    comments: comments,
    editAction: (index){
      //todo
    },
    removeAction: (index){
      //todo
    });
  }
}


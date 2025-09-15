import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../entities/travel.dart';
import '../../helpers/pickImageFromGallery.dart';

/// this widget return a SliverAppBar for the Travel view
class TravelViewSliverAppBar extends StatelessWidget {
  ///
  const TravelViewSliverAppBar({super.key, required this.travel});

  /// path of the image
  final Travel travel;


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      floating: true,
      snap: true,
      forceElevated: true,
      backgroundColor: Theme.of(context).cardColor,
      iconTheme: Theme.of(context).iconTheme,
      centerTitle: true,
      title: Text(
          'status',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {

            } else if (value == 'remove') {

            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text("Editar viagem"),
            ),
            const PopupMenuItem(
              value: 'remove',
              child: Text("Excluir viagem"),
            ),
          ],
        ),


      ],
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: pickImageFromGallery,
          child: travel.mainPicture != null
              ? Image.file(
            File(travel.mainPicture!),
            fit: BoxFit.cover,
          )
              : Container(
            color: Theme.of(context).canvasColor,
            child: const Center(
              child: Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ),

      bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Text(
              travel.travelName,
            style: Theme.of(context).textTheme.displayMedium,
          )
      ),
    );
  }
}

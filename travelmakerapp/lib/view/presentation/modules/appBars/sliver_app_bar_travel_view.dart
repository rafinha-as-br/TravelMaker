import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../entities/Travel.dart';
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
      backgroundColor: Theme.of(context).cardColor,
      centerTitle: true,
      title: const Text('status'),
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
            color: Colors.blueGrey,
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
          preferredSize: Size.fromHeight(40),
          child: Text(travel.travelName)
      ),
    );
  }
}

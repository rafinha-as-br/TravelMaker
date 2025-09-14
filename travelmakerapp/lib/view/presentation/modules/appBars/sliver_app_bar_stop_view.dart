import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../entities/travelStop.dart';
import '../../helpers/pickImageFromGallery.dart';

/// sliverAppBar dedicated to StopView Screen
class StopViewSliverAppBar extends StatelessWidget {
  const StopViewSliverAppBar({
    super.key, required this.stop, required this.index
  });

  /// the travelStop
  final TravelStop stop;

  /// index from the list
  final int index;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      floating: true,
      snap: true,
      forceElevated: true,
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(
        'status',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: pickImageFromGallery,
          child: stop.stopPicture != null
              ? Image.file(
            File(stop.stopPicture!),
            fit: BoxFit.cover,
          )
              : Container(
            color: Theme.of(context).colorScheme.secondary,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Parada: ${index+1}',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          )
      ),

    );
  }
}


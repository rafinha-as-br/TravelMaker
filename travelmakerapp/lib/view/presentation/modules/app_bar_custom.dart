import 'dart:io';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String? imagePath;

  const CustomSliverAppBar({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text("Meu Perfil"),
            background: imagePath != null && File(imagePath!).existsSync()
                ? Image.file(
              File(imagePath!),
              fit: BoxFit.cover,
            )
                : Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.account_circle,
                  size: 120,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
              title: Text("Item $index"),
            ),
            childCount: 20,
          ),
        ),
      ],
    );
  }
}

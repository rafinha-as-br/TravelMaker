import 'package:flutter/material.dart';

import '../../../entities/Travel.dart';

class TravelScreen extends StatelessWidget {
  const TravelScreen({super.key, required this.travel});

  final Travel travel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).cardColor,
            centerTitle: true,
            title: const Text('status'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "editar") {

                  } else if (value == "excluir") {

                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "editar",
                    child: Text("Editar viagem"),
                  ),
                  const PopupMenuItem(
                    value: "excluir",
                    child: Text("Excluir viagem"),
                  ),
                ],
              ),
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Text(travel.travelName)
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TravelListScreen extends StatelessWidget {
  const TravelListScreen({super.key});

  static const routeName = '/TravelListScreen';


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, asyncSnapshot) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
                itemBuilder: itemBuilder
            )
          ),
        );
      }
    );
  }
}


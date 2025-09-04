import 'package:flutter/material.dart';

class TravelListScreen extends StatelessWidget {
  const TravelListScreen({super.key});

  static const routeName = '/TravelListScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // need to remove the column and add a future builder calling the appState provider
          ],
        ),
      ),
    );
  }
}

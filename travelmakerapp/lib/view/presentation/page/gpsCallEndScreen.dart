import 'package:flutter/material.dart';

class GpsCallEndScreen extends StatelessWidget {
  const GpsCallEndScreen({super.key});

  static const routeName = '/gpsCallEndScreen';


  @override
  Widget build(BuildContext context) {
    return Text("Não é possivel rodar o app sem o GPS!");
  }
}

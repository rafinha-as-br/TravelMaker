import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  static const routeName = '/loadingScreen';

  // this need to become a widget not a screen itself

  @override
  Widget build(BuildContext context) {
    return Text("Loading Screen");
  }
}

import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        width: 80,
        child: CircularProgressIndicator(
          strokeWidth: 8,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          value: 0.7, // 70% completo
        ),
      ),
    );

  }
}

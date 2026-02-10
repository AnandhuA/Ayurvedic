import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:ayurvedic/views/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                CustomCardWidget(),
                AppSpacing.h12(),
                CustomCardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ayurvedic/core/constants/colors.dart';
import 'package:flutter/material.dart';

class LabelValueText extends StatelessWidget {
  final String label;
  final String value;

  const LabelValueText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: "$label:  ",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}

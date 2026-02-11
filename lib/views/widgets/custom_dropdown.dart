import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String title;
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final Function(T?) onChanged;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        AppSpacing.h16(),
        DropdownButtonFormField<T>(
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: AppRadius.br12()),
            contentPadding: AppPadding.p12,
          ),
          hint: Text(hint),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(labelBuilder(item)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

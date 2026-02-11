import 'package:ayurvedic/core/constants/colors.dart';
import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {
  final TextEditingController controller;
  final String titleText;
  final String hitText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextFeild({
    super.key,
    this.validator,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.titleText,
    required this.hitText,
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  late bool visibility;
  @override
  void initState() {
    visibility = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        Text(widget.titleText, style: TextStyle(fontWeight: FontWeight.w500)),
        AppSpacing.h12(),
        TextFormField(
          controller: widget.controller,
          obscureText: visibility,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hitText,
            fillColor: AppColors.grey.withValues(alpha: 0.2),
            border: OutlineInputBorder(
              borderRadius: AppRadius.br12(),
              borderSide: BorderSide(),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: Icon(
                      visibility ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

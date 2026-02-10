import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final double width;
  final double height;

  const CustomButtom({
    super.key,
    this.icon,
    this.isLoading = false,
    this.width = 100,
    this.height = 5,
    required this.title,
    required this.onTap,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MQ.w(context, width),
        height: MQ.h(context, height),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.br12(),
        ),
        child: isLoading
            ? Center(child: CupertinoActivityIndicator(color: textColor))
            : Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  if (icon != null) Icon(icon),
                  Text(title, style: TextStyle(color: textColor)),
                ],
              ),
      ),
    );
  }
}

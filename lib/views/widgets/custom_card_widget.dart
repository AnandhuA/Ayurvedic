import 'package:ayurvedic/core/constants/colors.dart';
import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MQ.width(context),
      decoration: BoxDecoration(
        borderRadius: AppRadius.br12(),
        color: AppColors.cardBgColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: AppPadding.p16,
            child: Row(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "1.",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                AppSpacing.w8(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "Vikram Singh",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSpacing.h12(),
                      Text(
                        "Couple Combo Package (Rejuve)Couple Combo Package (Rejuven)Couple Combo Package (Rejuven)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      AppSpacing.h12(),
                      Row(
                        children: [
                          _IconsTest(
                            icon: Icons.calendar_month,
                            text: "31/01/2024",
                          ),
                          AppSpacing.w8(),
                          _IconsTest(
                            icon: Icons.people_outline,
                            text: "Jithesh",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            children: [
              AppSpacing.w24(),
              Text("View Booking details"),
              Spacer(),
              Icon(Icons.chevron_right_sharp, color: AppColors.primaryDark),
              AppSpacing.w24(),
            ],
          ),
          AppSpacing.h12(),
        ],
      ),
    );
  }
}

class _IconsTest extends StatelessWidget {
  final IconData icon;
  final String text;
  const _IconsTest({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.red, size: 18),
        AppSpacing.w4(),
        Text(text, style: TextStyle(color: AppColors.textGrey)),
      ],
    );
  }
}

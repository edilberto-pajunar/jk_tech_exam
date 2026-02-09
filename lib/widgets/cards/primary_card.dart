import 'package:flutter/material.dart';
import 'package:jk_tech_exam/shared/colors.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}

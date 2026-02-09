import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_tech_exam/shared/colors.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderColor = AppColor.primaryColor,
    this.textColor = AppColor.primaryColor,
    this.borderRadius,
    required this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final String icon;
  final Color borderColor;
  final Color textColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.whiteColor,
        foregroundColor: textColor,
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, height: 20, width: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: theme.textTheme.bodyMedium!.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

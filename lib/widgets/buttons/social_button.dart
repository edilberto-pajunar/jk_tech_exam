import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_tech_exam/shared/colors.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.whiteColor,
        foregroundColor: AppColor.primaryColor,
        side: const BorderSide(color: AppColor.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.0),
      ),
      label: Text(text),
      icon: SvgPicture.asset(icon),
    );
  }
}

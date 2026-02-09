import 'package:flutter/material.dart';
import 'package:jk_tech_exam/shared/colors.dart';

enum ButtonVariant { primary, outlined, text }

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool enabled;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
  }) : variant = ButtonVariant.primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          disabledBackgroundColor: AppColor.disabledColor,
          backgroundColor: AppColor.primaryColor,
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

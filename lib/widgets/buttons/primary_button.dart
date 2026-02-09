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

  static const _radius = 48.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(_radius),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_radius),
              gradient: enabled
                  ? const LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.secondaryColor],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    )
                  : null,
              color: enabled ? backgroundColor : AppColor.disabledColor,
            ),
            child: Center(
              child: Text(
                text,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: textColor ?? AppColor.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

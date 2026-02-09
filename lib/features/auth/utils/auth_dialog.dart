import 'package:flutter/material.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';

class AuthDialog {
  static void showAccountLocked(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            "Account Locked",
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Please try logging in again after 10 minutes, or reset your password.",
            style: theme.textTheme.bodyMedium!.copyWith(
              color: AppColor.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            PrimaryButton(
              text: "Forgot Password",
              onPressed: () {
                print("Forgot Password");
              },
            ),
          ],
        );
      },
    );
  }

  static void showTermsAndConditionConsent(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(
            "Terms and Conditions Consent",
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            "To protect your rights, please read and accept the Terms of Use, Privacy Policy, Community Guidelines, and Cookie Policy.",
            style: theme.textTheme.bodyMedium!.copyWith(
              color: AppColor.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            PrimaryButton(
              text: "Forgot Password",
              onPressed: () {
                print("Forgot Password");
              },
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              backgroundColor: Colors.transparent,
              text: "Disagree",
              textColor: AppColor.blackColor,
              onPressed: () {
                print("Forgot Password");
              },
            ),
          ],
        );
      },
    );
  }
}

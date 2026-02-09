import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/auth/utils/auth_dialog.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("OTP")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Please check your email or message inbox for the OTP. If you don't see it, check your spam or junk folder.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: AppColor.greyColor,
              ),
            ),
            const SizedBox(height: 24.0),
            RichText(
              text: TextSpan(
                text: "Enter OTP",
                style: theme.textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "*",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: AppColor.errorColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Pinput(
              length: 6,
              defaultPinTheme: PinTheme(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  border: Border.all(color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (value) {
                print(value);
              },
            ),
            const SizedBox(height: 24.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Code is expiring in ",
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "300 seconds",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            PrimaryButton(
              text: "Next",
              onPressed: () {
                print("Next");
                AuthDialog.showTermsAndConditionConsent(context);
              },
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              backgroundColor: Colors.transparent,
              text: "Resend Code",
              textColor: AppColor.primaryColor,
              onPressed: () {
                print("Resend code");
                AuthDialog.showAccountLocked(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

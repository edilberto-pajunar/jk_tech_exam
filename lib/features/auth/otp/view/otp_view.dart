import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/auth/create_password/view/create_password_page.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  static const _mockOTP = "123456";
  static const _otpSeconds = 300;

  final _pinController = TextEditingController();
  late DateTime _expiresAt;
  int _remainingSeconds = _otpSeconds;
  Timer? _timer;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _expiresAt = DateTime.now().add(const Duration(seconds: _otpSeconds));
    _remainingSeconds = _expiresAt
        .difference(DateTime.now())
        .inSeconds
        .clamp(0, _otpSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final remaining = _expiresAt
          .difference(DateTime.now())
          .inSeconds
          .clamp(0, _otpSeconds);
      setState(() => _remainingSeconds = remaining);
      if (remaining == 0) _timer?.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  void _resendCode() {
    setState(() {
      _expiresAt = DateTime.now().add(const Duration(seconds: _otpSeconds));
      _remainingSeconds = _otpSeconds;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        final remaining = _expiresAt
            .difference(DateTime.now())
            .inSeconds
            .clamp(0, _otpSeconds);
        setState(() => _remainingSeconds = remaining);
        if (remaining == 0) _timer?.cancel();
      });
    });
  }

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
              controller: _pinController,
              defaultPinTheme: PinTheme(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  border: Border.all(
                    color: _showError
                        ? AppColor.errorColor
                        : AppColor.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (value) {
                if (_showError) setState(() => _showError = false);
              },
            ),
            if (_showError) ...[
              const SizedBox(height: 8.0),
              Text(
                "Double-check that you're entering the OTP exactly as received",
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColor.errorColor,
                ),
              ),
            ],
            const SizedBox(height: 24.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Code is expiring in ",
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "$_remainingSeconds seconds",
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
                if (_pinController.text == _mockOTP) {
                  context.pushNamed(CreatePasswordPage.route);
                  _timer?.cancel();
                  _pinController.clear();
                  setState(() => _showError = false);
                } else {
                  setState(() => _showError = true);
                }
              },
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              backgroundColor: AppColor.whiteColor,
              text: "Resend Code",
              textColor: _remainingSeconds == 0
                  ? AppColor.primaryColor
                  : AppColor.greyColor,
              onPressed: _remainingSeconds == 0 ? _resendCode : null,
              enabled: true,
              disabledColor: AppColor.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}

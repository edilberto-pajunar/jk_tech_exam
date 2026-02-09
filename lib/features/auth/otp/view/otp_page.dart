import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/auth/otp/view/otp_view.dart';

class OtpPage extends StatelessWidget {
  static String route = "otp_route";
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OtpView();
  }
}

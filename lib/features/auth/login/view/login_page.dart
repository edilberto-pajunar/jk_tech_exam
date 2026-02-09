import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_view.dart';

class LoginPage extends StatelessWidget {
  static String route = "login_route";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}

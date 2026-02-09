import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/auth/register/view/register_view.dart';

class RegisterPage extends StatelessWidget {
  static String route = "register_route";
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterView();
  }
}

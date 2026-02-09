import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/auth/create_password/view/create_password_view.dart';

class CreatePasswordPage extends StatelessWidget {
  static String route = "create_password_route";
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreatePasswordView();
  }
}

import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/auth/create_profile/view/create_profile_view.dart';

class CreateProfilePage extends StatelessWidget {
  static String route = "create_profile_route";
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateProfileView();
  }
}

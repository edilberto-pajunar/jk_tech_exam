import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/dashboard/account/view/account_view.dart';

class AccountPage extends StatelessWidget {
  static String route = "account_route";
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountView();
  }
}

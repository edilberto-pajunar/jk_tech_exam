import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/app/bloc/app_bloc.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_page.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButton(
                  text: "Logout",
                  onPressed: () {
                    context.read<AppBloc>().add(const AppLogoutRequested());
                    context.goNamed(LoginPage.route);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

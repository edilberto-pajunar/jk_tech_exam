import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/features/auth/login/bloc/login_bloc.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_view.dart';

class LoginPage extends StatelessWidget {
  static String route = "login_route";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<LoginBloc>(),
      child: const LoginView(),
    );
  }
}

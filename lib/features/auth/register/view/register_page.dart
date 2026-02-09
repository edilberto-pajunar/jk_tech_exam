import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/features/auth/register/bloc/register_bloc.dart';
import 'package:jk_tech_exam/features/auth/register/view/register_view.dart';

class RegisterPage extends StatelessWidget {
  static String route = "register_route";
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<RegisterBloc>(),
      child: const RegisterView(),
    );
  }
}

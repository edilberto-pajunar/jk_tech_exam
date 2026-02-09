import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/features/auth/create_password/view/create_password_view.dart';
import 'package:jk_tech_exam/features/auth/register/bloc/register_bloc.dart';

class CreatePasswordPage extends StatelessWidget {
  static String route = "create_password_route";
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<RegisterBloc>(),
      child: const CreatePasswordView(),
    );
  }
}

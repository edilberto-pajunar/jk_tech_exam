import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/app/bloc/app_bloc.dart';
import 'package:jk_tech_exam/features/dashboard/account/view/account_view.dart';

class AccountPage extends StatelessWidget {
  static String route = "account_route";
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AppBloc>(),
      child: const AccountView(),
    );
  }
}

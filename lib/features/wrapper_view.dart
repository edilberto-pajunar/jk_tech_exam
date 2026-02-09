import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/app/bloc/app_bloc.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_page.dart';
import 'package:jk_tech_exam/features/dashboard/home/view/home_page.dart';

class WrapperView extends StatefulWidget {
  const WrapperView({super.key});

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView> {
  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(const AppInitRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) =>
          previous.authStatus != current.authStatus,
      listener: (context, state) {
        if (state.authStatus == AppAuthStatus.unauthenticated) {
          context.goNamed(LoginPage.route);
        } else {
          context.goNamed(HomePage.route);
        }
      },
      builder: (context, state) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

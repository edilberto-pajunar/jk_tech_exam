import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/app/bloc/app_bloc.dart';
import 'package:jk_tech_exam/features/wrapper_view.dart';

class WrapperPage extends StatelessWidget {
  static String route = "wrapper_route";
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AppBloc>(),
      child: const WrapperView(),
    );
  }
}

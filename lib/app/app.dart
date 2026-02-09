import 'package:flutter/material.dart';
import 'package:jk_tech_exam/app/app_router.dart';
import 'package:jk_tech_exam/shared/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.themeData,
    );
  }
}

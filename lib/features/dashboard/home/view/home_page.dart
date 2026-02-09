import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/dashboard/home/view/home_view.dart';

class HomePage extends StatelessWidget {
  static String route = "home_route";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

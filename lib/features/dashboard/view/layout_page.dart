import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/dashboard/view/layout_view.dart';
import 'package:jk_tech_exam/shared/image.dart';

enum LayoutPageTab {
  home(title: "Home", icon: AppImage.homeOutlined),
  videos(title: "Videos", icon: AppImage.videoOutlined),
  message(title: "Message", icon: AppImage.messageOutlined),
  account(title: "Account", icon: AppImage.profileOutlined);

  final String title;
  final String icon;

  const LayoutPageTab({required this.title, required this.icon});
}

class LayoutPage extends StatelessWidget {
  static String route = "layout_route";
  const LayoutPage({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return LayoutView(shell: shell);
  }
}

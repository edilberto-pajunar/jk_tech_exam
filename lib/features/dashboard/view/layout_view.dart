import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/dashboard/view/layout_page.dart';
import 'package:jk_tech_exam/shared/colors.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    // List of exact routes where the bottom nav bar should show
    const tabRoutes = ["/home", "/videos", "/message", "/account"];

    // Show bottom nav only if we are on a tab route
    final showBottomNav = tabRoutes.contains(location);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          // Get the current tab index
          final currentIndex = shell.currentIndex;

          // If we're not on the home tab (index 0), go back to home
          if (currentIndex != 0) {
            shell.goBranch(0);
          }
        }
      },
      child: Scaffold(
        body: shell,
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            bottomAppBarTheme: const BottomAppBarThemeData(
              shadowColor: Colors.transparent,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              enableFeedback: false,
            ),
          ),
          child: showBottomNav
              ? SizedBox(
                  child: BottomNavigationBar(
                    currentIndex: shell.currentIndex,
                    onTap: (index) {
                      shell.goBranch(index, initialLocation: true);
                    },
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    fixedColor: AppColor.primaryColor,
                    selectedFontSize: 12,
                    items: LayoutPageTab.values
                        .map(
                          (tab) => BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              tab.icon,
                              width: 24,
                              height: 24,
                              colorFilter:
                                  shell.currentIndex ==
                                      LayoutPageTab.values.indexOf(tab)
                                  ? const ColorFilter.mode(
                                      AppColor.primaryColor,
                                      BlendMode.srcIn,
                                    )
                                  : null,
                            ),
                            label: tab.title,
                          ),
                        )
                        .toList(),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

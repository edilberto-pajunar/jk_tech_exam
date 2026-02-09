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
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // First two tabs (Home, Videos)
                          ...LayoutPageTab.values.take(2).map((tab) {
                            final index = LayoutPageTab.values.indexOf(tab);
                            final isSelected = shell.currentIndex == index;
                            return _buildNavItem(
                              tab: tab,
                              isSelected: isSelected,
                              onTap: () =>
                                  shell.goBranch(index, initialLocation: true),
                            );
                          }),
                          // Center FAB
                          _buildCenterButton(),
                          // Last two tabs (Message, Account)
                          ...LayoutPageTab.values.skip(2).map((tab) {
                            final index = LayoutPageTab.values.indexOf(tab);
                            final isSelected = shell.currentIndex == index;
                            return _buildNavItem(
                              tab: tab,
                              isSelected: isSelected,
                              onTap: () =>
                                  shell.goBranch(index, initialLocation: true),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: IconButton(
              onPressed: () {
                // Add your action here
              },
              icon: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required LayoutPageTab tab,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              tab.icon,
              width: 24,
              height: 24,
              colorFilter: isSelected
                  ? const ColorFilter.mode(
                      AppColor.primaryColor,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              tab.title,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColor.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

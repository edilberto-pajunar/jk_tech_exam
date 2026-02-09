import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/auth/create_password/view/create_password_page.dart';
import 'package:jk_tech_exam/features/auth/create_profile/view/create_profile_page.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_page.dart';
import 'package:jk_tech_exam/features/auth/otp/view/otp_page.dart';
import 'package:jk_tech_exam/features/auth/register/view/register_page.dart';
import 'package:jk_tech_exam/features/dashboard/account/view/account_page.dart';
import 'package:jk_tech_exam/features/dashboard/home/view/home_page.dart';
import 'package:jk_tech_exam/features/dashboard/message/view/message_page.dart';
import 'package:jk_tech_exam/features/dashboard/videos/view/videos_page.dart';
import 'package:jk_tech_exam/features/dashboard/view/layout_view.dart';
import 'package:jk_tech_exam/features/wrapper_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: WrapperPage.route,
        builder: (context, state) => const WrapperPage(),
      ),
      GoRoute(
        path: "/login",
        name: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/register",
        name: RegisterPage.route,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: "/create-account",
        name: CreateProfilePage.route,
        builder: (context, state) => const CreateProfilePage(),
      ),
      GoRoute(
        path: "/create-password",
        name: CreatePasswordPage.route,
        builder: (context, state) => const CreatePasswordPage(),
      ),
      GoRoute(
        path: "/otp",
        name: OtpPage.route,
        builder: (context, state) => const OtpPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            LayoutView(shell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/home",
                name: HomePage.route,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/videos",
                name: VideosPage.route,
                builder: (context, state) => const VideosPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/message",
                name: MessagePage.route,
                builder: (context, state) => const MessagePage(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/account",
                name: AccountPage.route,
                builder: (context, state) => const AccountPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

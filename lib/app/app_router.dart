import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/auth/create_profile/view/create_profile_page.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_page.dart';
import 'package:jk_tech_exam/features/auth/register/view/register_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/",
        name: RegisterPage.route,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: "/",
        name: CreateProfilePage.route,
        builder: (context, state) => const CreateProfilePage(),
      ),
    ],
  );
}

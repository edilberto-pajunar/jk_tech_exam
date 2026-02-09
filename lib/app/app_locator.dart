import 'package:get_it/get_it.dart';
import 'package:jk_tech_exam/app/bloc/app_bloc.dart';
import 'package:jk_tech_exam/features/auth/create_profile/cubit/create_profile_cubit.dart';
import 'package:jk_tech_exam/features/auth/login/bloc/login_bloc.dart';
import 'package:jk_tech_exam/features/auth/register/bloc/register_bloc.dart';
import 'package:jk_tech_exam/features/auth/repository/auth_repository.dart';
import 'package:jk_tech_exam/features/auth/repository/i_auth_repository.dart';
import 'package:jk_tech_exam/features/wrapper_page.dart';
import 'package:jk_tech_exam/local/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // SERVICES
  getIt.registerSingleton<SharedPreferenceService>(
    SharedPreferenceService(prefs: await SharedPreferences.getInstance()),
  );

  // REPOSITORIES
  getIt.registerLazySingleton<AuthRepository>(() => IAuthRepository());

  // BLOCS
  getIt.registerLazySingleton<RegisterBloc>(
    () => RegisterBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LoginBloc>(
    () => LoginBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<AppBloc>(() => AppBloc());

  // CUBITS
  getIt.registerLazySingleton<CreateProfileCubit>(() => CreateProfileCubit());
}

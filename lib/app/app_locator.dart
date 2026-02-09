import 'package:get_it/get_it.dart';
import 'package:jk_tech_exam/features/auth/create_profile/cubit/create_profile_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<CreateProfileCubit>(() => CreateProfileCubit());
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';
import 'package:jk_tech_exam/local/shared_preference_service.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppInitRequested>(_onInitRequested);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  void _onInitRequested(AppInitRequested event, Emitter<AppState> emit) async {
    final user = getIt<SharedPreferenceService>().getString("currentUser");
    if (user == null) {
      emit(state.copyWith(authStatus: AppAuthStatus.unauthenticated));
    } else {
      emit(
        state.copyWith(
          authStatus: AppAuthStatus.authenticated,
          user: AppUser.fromJson(jsonDecode(user)),
        ),
      );
    }
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) async {
    await getIt<SharedPreferenceService>().clear();
    emit(state.copyWith(authStatus: AppAuthStatus.unauthenticated, user: null));
  }
}

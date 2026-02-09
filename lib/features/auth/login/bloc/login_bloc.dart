import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/client/model/api_exceptions.dart';
import 'package:jk_tech_exam/features/auth/repository/auth_repository.dart';
import 'package:jk_tech_exam/local/shared_preference_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginState()) {
    on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final user = await _authRepository.login(email: event.email, password: event.password);
      await getIt<SharedPreferenceService>().setString(
        "currentUser",
        jsonEncode(user.toJson()),
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on ApiExceptions catch (e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.message));
    }
  }
}

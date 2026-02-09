import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/client/model/api_exceptions.dart';
import 'package:jk_tech_exam/features/auth/repository/auth_repository.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';
import 'package:jk_tech_exam/local/shared_preference_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const RegisterState()) {
    on<RegisterEmailRequested>(_onEmailRequested);
    on<RegisterAccountRequested>(_onAccountRequested);
  }

  void _onEmailRequested(
    RegisterEmailRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      final user = await _authRepository.validateEmail(event.email);
      emit(state.copyWith(status: RegisterStatus.success, user: user));
    } on ApiExceptions catch (e) {
      print("Exception type: ${e.message}");

      emit(
        state.copyWith(status: RegisterStatus.error, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onAccountRequested(
    RegisterAccountRequested event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.user == null) {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errorMessage: "User not found",
        ),
      );
      return;
    }
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      final user = await _authRepository.createAccount(
        password: event.password,
        email: state.user!.email,
      );
      await getIt<SharedPreferenceService>().setString(
        "currentUser",
        jsonEncode(user.toJson()),
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } on ApiExceptions catch (e) {
      emit(
        state.copyWith(status: RegisterStatus.error, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String? errorMessage;
  final AppUser? user;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.user,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
    AppUser? user,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}

part of 'app_bloc.dart';

enum AppStatus { initial, loading, success, error }

enum AppAuthStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  final AppStatus status;
  final AppAuthStatus authStatus;
  final AppUser? user;
  final String? errorMessage;

  const AppState({
    this.status = AppStatus.initial,
    this.authStatus = AppAuthStatus.unauthenticated,
    this.user,
    this.errorMessage,
  });

  AppState copyWith({
    AppStatus? status,
    AppAuthStatus? authStatus,
    AppUser? user,
    String? errorMessage,
  }) {
    return AppState(
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, authStatus, user, errorMessage];
}

part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailRequested extends RegisterEvent {
  final String email;
  const RegisterEmailRequested({required this.email});
}

class RegisterAccountRequested extends RegisterEvent {
  final String password;
  const RegisterAccountRequested({required this.password});
}

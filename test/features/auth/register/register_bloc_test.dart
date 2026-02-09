import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jk_tech_exam/client/model/api_exceptions.dart';
import 'package:jk_tech_exam/features/auth/register/bloc/register_bloc.dart';
import 'package:jk_tech_exam/features/auth/repository/auth_repository.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterBloc registerBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerBloc = RegisterBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    registerBloc.close();
  });

  const _user = AppUser(
    id: '1',
    fullName: 'Test User',
    imageUrl: '',
    email: 'test@example.com',
  );

  group('RegisterBloc', () {
    test('initial state is RegisterState.initial', () {
      expect(registerBloc.state, const RegisterState());
    });

    blocTest<RegisterBloc, RegisterState>(
      'emits [loading, success] and user when RegisterEmailRequested succeeds',
      build: () {
        final mock = MockAuthRepository();
        when(mock.validateEmail('test@example.com')).thenAnswer((_) async => _user);
        return RegisterBloc(authRepository: mock);
      },
      act: (bloc) =>
          bloc.add(const RegisterEmailRequested(email: 'test@example.com')),
      expect: () => [
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(status: RegisterStatus.success, user: _user),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [loading, error] when RegisterEmailRequested throws ApiExceptions',
      build: () {
        final mock = MockAuthRepository();
        when(mock.validateEmail('test@example.com'))
            .thenThrow(ApiExceptions('email error'));
        return RegisterBloc(authRepository: mock);
      },
      act: (bloc) =>
          bloc.add(const RegisterEmailRequested(email: 'test@example.com')),
      expect: () => [
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
          status: RegisterStatus.error,
          errorMessage: 'email error',
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits error when RegisterAccountRequested is added without user',
      build: () => RegisterBloc(authRepository: MockAuthRepository()),
      act: (bloc) =>
          bloc.add(const RegisterAccountRequested(password: 'password')),
      expect: () => [
        const RegisterState(
          status: RegisterStatus.error,
          errorMessage: 'User not found',
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [loading, success] when RegisterAccountRequested succeeds',
      build: () {
        final mock = MockAuthRepository();
        when(mock.createAccount(
          password: 'password',
          email: 'test@example.com',
        )).thenAnswer((_) async {});
        return RegisterBloc(authRepository: mock)..emit(RegisterState(user: _user));
      },
      act: (bloc) =>
          bloc.add(const RegisterAccountRequested(password: 'password')),
      expect: () => [
        const RegisterState(status: RegisterStatus.loading, user: _user),
        const RegisterState(status: RegisterStatus.success, user: _user),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [loading, error] when RegisterAccountRequested throws ApiExceptions',
      build: () {
        final mock = MockAuthRepository();
        when(mock.createAccount(
          password: 'password',
          email: 'test@example.com',
        )).thenThrow(ApiExceptions('account error'));
        return RegisterBloc(authRepository: mock)..emit(RegisterState(user: _user));
      },
      act: (bloc) =>
          bloc.add(const RegisterAccountRequested(password: 'password')),
      expect: () => [
        const RegisterState(status: RegisterStatus.loading, user: _user),
        const RegisterState(
          status: RegisterStatus.error,
          errorMessage: 'account error',
          user: _user,
        ),
      ],
    );
  });
}

import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/client/model/api_exceptions.dart';
import 'package:jk_tech_exam/features/auth/login/bloc/login_bloc.dart';
import 'package:jk_tech_exam/features/auth/repository/auth_repository.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';
import 'package:jk_tech_exam/local/shared_preference_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, SharedPreferenceService])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockSharedPreferenceService mockSharedPrefs;
  late LoginBloc loginBloc;
  LoginBloc? blocTestBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockSharedPrefs = MockSharedPreferenceService();
    getIt.registerSingleton<SharedPreferenceService>(mockSharedPrefs);
    loginBloc = LoginBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    loginBloc.close();
    getIt.reset();
  });

  group('LoginBloc', () {
    test('initial state is LoginState.initial', () {
      expect(loginBloc.state, const LoginState());
    });

    blocTest<LoginBloc, LoginState>(
      'emits [loading, success] when LoginRequested succeeds',
      build: () {
        if (getIt.isRegistered<SharedPreferenceService>()) {
          getIt.unregister<SharedPreferenceService>();
        }
        final mockAuth = MockAuthRepository();
        final mockPrefs = MockSharedPreferenceService();
        final user = const AppUser(
          id: '1',
          fullName: 'Test User',
          imageUrl: '',
          email: 'test@example.com',
        );
        when(mockAuth.login(
          email: 'test@example.com',
          password: 'password',
        )).thenAnswer((_) async => user);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async {});
        getIt.registerSingleton<SharedPreferenceService>(mockPrefs);
        blocTestBloc = LoginBloc(authRepository: mockAuth);
        return blocTestBloc!;
      },
      act: (bloc) => bloc.add(
        const LoginRequested(email: 'test@example.com', password: 'password'),
      ),
      expect: () => [
        const LoginState(status: LoginStatus.loading),
        const LoginState(status: LoginStatus.success),
      ],
      tearDown: () {
        blocTestBloc?.close();
        getIt.reset();
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loading, error] when LoginRequested throws ApiExceptions',
      build: () {
        if (getIt.isRegistered<SharedPreferenceService>()) {
          getIt.unregister<SharedPreferenceService>();
        }
        final mockAuth = MockAuthRepository();
        final mockPrefs = MockSharedPreferenceService();
        when(
          mockAuth.login(email: 'test@example.com', password: 'password'),
        ).thenThrow(ApiExceptions('Invalid credentials'));
        getIt.registerSingleton<SharedPreferenceService>(mockPrefs);
        blocTestBloc = LoginBloc(authRepository: mockAuth);
        return blocTestBloc!;
      },
      act: (bloc) => bloc.add(
        const LoginRequested(email: 'test@example.com', password: 'password'),
      ),
      expect: () => [
        const LoginState(status: LoginStatus.loading),
        const LoginState(
          status: LoginStatus.error,
          errorMessage: 'Invalid credentials',
        ),
      ],
      tearDown: () {
        blocTestBloc?.close();
        getIt.reset();
      },
    );
  });
}

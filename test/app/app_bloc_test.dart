import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jk_tech_exam/app/app_locator.dart';
import 'package:jk_tech_exam/app/bloc/app_bloc.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';
import 'package:jk_tech_exam/local/shared_preference_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_bloc_test.mocks.dart';

@GenerateMocks([SharedPreferenceService])
void main() {
  late MockSharedPreferenceService mockSharedPrefs;
  late AppBloc appBloc;

  setUp(() {
    mockSharedPrefs = MockSharedPreferenceService();
    getIt.registerSingleton<SharedPreferenceService>(mockSharedPrefs);
    appBloc = AppBloc();
  });

  tearDown(() {
    appBloc.close();
    getIt.reset();
  });

  group('AppBloc', () {
    test('initial state is AppState.initial', () {
      expect(
        appBloc.state,
        const AppState(authStatus: AppAuthStatus.unauthenticated),
      );
    });

    blocTest<AppBloc, AppState>(
      'emits unauthenticated when AppInitRequested and no user in prefs',
      build: () {
        if (getIt.isRegistered<SharedPreferenceService>()) {
          getIt.unregister<SharedPreferenceService>();
        }
        final mock = MockSharedPreferenceService();
        when(mock.getString('currentUser')).thenReturn(null);
        when(mock.clear()).thenAnswer((_) async {});
        getIt.registerSingleton<SharedPreferenceService>(mock);
        return AppBloc();
      },
      act: (bloc) => bloc.add(const AppInitRequested()),
      expect: () => [
        const AppState(authStatus: AppAuthStatus.unauthenticated),
      ],
      tearDown: () => getIt.reset(),
    );

    blocTest<AppBloc, AppState>(
      'emits authenticated with user when AppInitRequested and user in prefs',
      build: () {
        if (getIt.isRegistered<SharedPreferenceService>()) {
          getIt.unregister<SharedPreferenceService>();
        }
        final mock = MockSharedPreferenceService();
        const user = AppUser(
          id: '1',
          fullName: 'Test User',
          imageUrl: '',
          email: 'test@example.com',
        );
        when(mock.getString('currentUser'))
            .thenReturn(jsonEncode(user.toJson()));
        when(mock.clear()).thenAnswer((_) async {});
        getIt.registerSingleton<SharedPreferenceService>(mock);
        return AppBloc();
      },
      act: (bloc) => bloc.add(const AppInitRequested()),
      expect: () => [
        isA<AppState>()
            .having((s) => s.authStatus, 'authStatus', AppAuthStatus.authenticated)
            .having((s) => s.user?.id, 'user.id', '1')
            .having((s) => s.user?.email, 'user.email', 'test@example.com'),
      ],
      tearDown: () => getIt.reset(),
    );

    blocTest<AppBloc, AppState>(
      'emits unauthenticated and clears prefs when AppLogoutRequested',
      build: () {
        if (getIt.isRegistered<SharedPreferenceService>()) {
          getIt.unregister<SharedPreferenceService>();
        }
        final mock = MockSharedPreferenceService();
        when(mock.clear()).thenAnswer((_) async {});
        getIt.registerSingleton<SharedPreferenceService>(mock);
        return AppBloc();
      },
      seed: () => const AppState(
        authStatus: AppAuthStatus.authenticated,
        user: AppUser(
          id: '1',
          fullName: 'Test',
          imageUrl: '',
          email: 'test@example.com',
        ),
      ),
      act: (bloc) => bloc.add(const AppLogoutRequested()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authStatus,
          'authStatus',
          AppAuthStatus.unauthenticated,
        ),
      ],
      tearDown: () => getIt.reset(),
    );
  });
}

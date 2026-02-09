import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jk_tech_exam/features/auth/create_profile/cubit/create_profile_cubit.dart';

void main() {
  group('CreateProfileCubit', () {
    test('initial state is CreateProfileState with activePage 0', () {
      expect(CreateProfileCubit().state, const CreateProfileState(activePage: 0));
    });

    blocTest<CreateProfileCubit, CreateProfileState>(
      'emits state with incremented activePage when nextPage is called',
      build: CreateProfileCubit.new,
      act: (cubit) => cubit.nextPage(),
      expect: () => [const CreateProfileState(activePage: 1)],
    );

    blocTest<CreateProfileCubit, CreateProfileState>(
      'emits state with decremented activePage when previousPage is called',
      build: CreateProfileCubit.new,
      seed: () => const CreateProfileState(activePage: 2),
      act: (cubit) => cubit.previousPage(),
      expect: () => [const CreateProfileState(activePage: 1)],
    );

    blocTest<CreateProfileCubit, CreateProfileState>(
      'emits multiple states when nextPage is called twice',
      build: CreateProfileCubit.new,
      act: (cubit) => cubit
        ..nextPage()
        ..nextPage(),
      expect: () => [
        const CreateProfileState(activePage: 1),
        const CreateProfileState(activePage: 2),
      ],
    );

    blocTest<CreateProfileCubit, CreateProfileState>(
      'emits state with activePage 0 when previousPage from 1',
      build: CreateProfileCubit.new,
      seed: () => const CreateProfileState(activePage: 1),
      act: (cubit) => cubit.previousPage(),
      expect: () => [const CreateProfileState(activePage: 0)],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/modules/auth/domain/usecases/save_user_data.dart';
import 'package:challenge/app/modules/auth/presenter/auth_cubit.dart';
import 'package:challenge/app/modules/auth/presenter/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveUserData extends Mock implements ISaveUserData {}

void main() {
  late MockSaveUserData saveUserData;
  const user = User(name: 'Raphael', email: 'raphael@test.com');

  setUpAll(() {
    saveUserData = MockSaveUserData();
  });
  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits [] when nothing is called',
      build: () => AuthCubit(saveUserData),
      expect: () => const <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthSuccessState] when saveUserData works',
      build: () => AuthCubit(saveUserData),
      act: (cubit) async {
        when(() => saveUserData(user)).thenAnswer((_) async => true);
        await cubit.save(user);
      },
      expect: () => <AuthState>[
        AuthLoadingState(),
        AuthSuccessState(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthErrorState] when saveUserData has EmptyCredentials',
      build: () => AuthCubit(saveUserData),
      act: (cubit) async {
        const user = User(name: '', email: '');
        when(() => saveUserData(user)).thenThrow(EmptyCredentials());
        await cubit.save(user);
      },
      expect: () => <AuthState>[
        AuthLoadingState(),
        AuthErrorState("The Field shouldn't be empty"),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthErrorState] when saveUserData has Generic error',
      build: () => AuthCubit(saveUserData),
      act: (cubit) async {
        const user = User(name: '', email: '');
        when(() => saveUserData(user)).thenThrow(Exception("Generic error"));
        await cubit.save(user);
      },
      expect: () => <AuthState>[
        AuthLoadingState(),
        AuthErrorState("Please contact support."),
      ],
    );
  });
}

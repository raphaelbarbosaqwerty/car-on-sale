import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/modules/auth/domain/save_user_data.dart';
import 'package:challenge/app/modules/auth/presenter/auth_cubit.dart';
import 'package:challenge/app/modules/auth/presenter/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveUserData extends Mock implements ISaveUserData {}

void main() {
  group('AuthCubit', () {
    late MockSaveUserData saveUserData;
    final user = User(name: 'John Doe', email: 'john.doe@example.com');

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
        'emits [AuthErrorState] when saveUserData is false',
        build: () => AuthCubit(saveUserData),
        act: (cubit) async {
          final user = User(name: '', email: '');
          when(() => saveUserData(user)).thenThrow(EmptyCredentials());
          await cubit.save(user);
        },
        expect: () => <AuthState>[
          AuthLoadingState(),
        ],
        errors: () => [isA<EmptyCredentials>()],
      );
    });
  });
}

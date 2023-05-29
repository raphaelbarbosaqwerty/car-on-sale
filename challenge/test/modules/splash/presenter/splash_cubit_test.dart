import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:challenge/app/modules/splash/presenter/splash_cubit.dart';
import 'package:challenge/app/modules/splash/presenter/splash_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockValidateCachedUser extends Mock implements IValidateCachedUser {}

void main() {
  late MockValidateCachedUser validateCachedUser;

  setUpAll(() {
    validateCachedUser = MockValidateCachedUser();
  });

  group('SplashCubit', () {
    blocTest<SplashCubit, SplashState>(
      'emits [] when nothing is called',
      build: () => SplashCubit(validateCachedUser),
      expect: () => const <SplashState>[],
    );

    blocTest<SplashCubit, SplashState>(
      'emits [SplashLoadingState, SplashCacheFilledState] when validateCachedUser is true',
      build: () => SplashCubit(validateCachedUser),
      act: (cubit) async {
        when(() => validateCachedUser()).thenAnswer((_) async => true);
        await cubit.validateCache();
      },
      expect: () => <SplashState>[
        SplashLoadingState(),
        SplashCacheFilledState(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'emits [SplashLoadingState, SplashCacheEmptyState] when validateCachedUser is false',
      build: () => SplashCubit(validateCachedUser),
      act: (cubit) async {
        when(() => validateCachedUser()).thenAnswer((_) async => false);
        await cubit.validateCache();
      },
      expect: () => <SplashState>[
        SplashLoadingState(),
        SplashCacheEmptyState(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'emits [SplashLoadingState, SplashCacheEmptyState] when validateCachedUser has UserNotFound',
      build: () => SplashCubit(validateCachedUser),
      act: (cubit) async {
        when(() => validateCachedUser()).thenThrow(UserNotFound());
        await cubit.validateCache();
      },
      expect: () => <SplashState>[
        SplashLoadingState(),
        SplashCacheEmptyState(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'emits [SplashLoadingState, SplashCacheEmptyState] when validateCachedUser has generic UserErrors',
      build: () => SplashCubit(validateCachedUser),
      act: (cubit) async {
        when(() => validateCachedUser()).thenThrow(Exception("Some exception"));
        await cubit.validateCache();
      },
      expect: () => <SplashState>[
        SplashLoadingState(),
        SplashCacheEmptyState(),
      ],
    );
  });
}

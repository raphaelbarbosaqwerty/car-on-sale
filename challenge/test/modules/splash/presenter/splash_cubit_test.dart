import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/app/core/domain/usecases/validate_cached_user.dart';
import 'package:challenge/app/modules/splash/presenter/splash_cubit.dart';
import 'package:challenge/app/modules/splash/presenter/splash_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockValidateCachedUser extends Mock implements IValidateCachedUser {}

void main() {
  group('SplashCubit', () {
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
        'emits [SplashCacheFilledState] when validateCachedUser is true',
        build: () => SplashCubit(validateCachedUser),
        act: (cubit) async {
          when(() => validateCachedUser()).thenAnswer((_) async => true);
          await cubit.validateCache();
        },
        expect: () => <SplashState>[
          SplashCacheFilledState(),
        ],
      );

      blocTest<SplashCubit, SplashState>(
        'emits [SplashCacheEmptyState] when validateCachedUser is false',
        build: () => SplashCubit(validateCachedUser),
        act: (cubit) async {
          when(() => validateCachedUser()).thenAnswer((_) async => false);
          await cubit.validateCache();
        },
        expect: () => <SplashState>[
          SplashCacheEmptyState(),
        ],
      );
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/app/core/domain/errors/user_errors.dart';
import 'package:challenge/app/core/domain/usecases/do_logout.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_cubit.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDoLogout extends Mock implements IDoLogout {}

class MockLogoutCubit extends Mock implements LogoutCubit {}

void main() {
  late MockDoLogout doLogout;

  setUpAll(() {
    doLogout = MockDoLogout();
  });

  group('LogoutCubit - States tests', () {
    blocTest<LogoutCubit, LogoutState>(
      'emits [] when nothing is called',
      build: () => LogoutCubit(doLogout),
      expect: () => const <LogoutState>[],
    );

    blocTest<LogoutCubit, LogoutState>(
      'emits [LogoutLoadingState, LogoutSuccessState] when user was able to logout',
      build: () => LogoutCubit(doLogout),
      act: (cubit) async {
        when(() => doLogout()).thenAnswer(
          (_) async => true,
        );
        await cubit.logout();
      },
      expect: () => <LogoutState>[
        LogoutLoadingState(),
        LogoutSuccessState(),
      ],
    );

    blocTest<LogoutCubit, LogoutState>(
      'emits [LogoutLoadingState, LogoutErrorWithExtraState] when doLogout has UnableToClearUserCredentials',
      build: () => LogoutCubit(doLogout),
      act: (cubit) async {
        when(() => doLogout()).thenThrow(UnableToClearUserCredentials());
        await cubit.logout();
      },
      expect: () => <LogoutState>[
        LogoutLoadingState(),
        LogoutErrorState(),
      ],
    );

    blocTest<LogoutCubit, LogoutState>(
      'emits [LogoutLoadingState, LogoutErrorState] when doLogout has generic ApiError',
      build: () => LogoutCubit(doLogout),
      act: (cubit) async {
        when(() => doLogout()).thenThrow(Exception("Generic error"));
        await cubit.logout();
      },
      expect: () => <LogoutState>[LogoutLoadingState(), LogoutErrorState()],
    );
  });
}

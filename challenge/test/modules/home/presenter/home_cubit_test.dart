import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/app/core/domain/errors/api_errors.dart';
import 'package:challenge/app/core/domain/errors/generic_errors.dart';
import 'package:challenge/app/core/domain/models/api_error.dart';
import 'package:challenge/app/core/domain/models/api_error_params.dart';
import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/usecases/search_car_by_vin_number.dart';
import 'package:challenge/app/modules/home/presenter/home_cubit.dart';
import 'package:challenge/app/modules/home/presenter/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchCarByVinNumber extends Mock implements ISearchCarByVinNumber {}

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  late MockSearchCarByVinNumber searchCarByVinNumber;
  late CarInformation carInformation;
  const vinCode = "1337EXAMPLEOFVINN";
  late List<CarAdditionalInfo> suggestions;
  late InternalApiError internalApiError = InternalApiError(const ApiError(
    message: "Error",
    msgKey: "Error",
    params: ApiErrorParams(
      delaySeconds: 1337,
    ),
  ));

  setUpAll(() {
    searchCarByVinNumber = MockSearchCarByVinNumber();
    carInformation = const CarInformation(
      externalId: vinCode,
    );
    suggestions = <CarAdditionalInfo>[
      const CarAdditionalInfo(
          make: "cos",
          model: "cos-4",
          containerName: "1234",
          similarity: 98,
          externalId: "3232"),
      const CarAdditionalInfo(
          make: "cos",
          model: "cos-4",
          containerName: "1234",
          similarity: 24,
          externalId: "3232"),
    ];
  });

  group('HomeCubit - States tests', () {
    blocTest<HomeCubit, HomeState>(
      'emits [] when nothing is called',
      build: () => HomeCubit(searchCarByVinNumber),
      expect: () => const <HomeState>[],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoadingState, HomeSuccessState] when was able to search CarInformation',
      build: () => HomeCubit(searchCarByVinNumber),
      act: (cubit) async {
        when(() => searchCarByVinNumber(vinCode)).thenAnswer(
          (_) async => (carInformation, const <CarAdditionalInfo>[]),
        );
        await cubit.searchByVin(vinCode);
      },
      expect: () => <HomeState>[
        HomeLoadingState(),
        HomeSuccessState(carInformation, const <CarAdditionalInfo>[]),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoadingState, HomeSuccessState] when was able to search a list of suggestions',
      build: () => HomeCubit(searchCarByVinNumber),
      act: (cubit) async {
        when(() => searchCarByVinNumber(vinCode)).thenAnswer(
          (_) async => (const CarInformation(), suggestions),
        );
        await cubit.searchByVin(vinCode);
      },
      expect: () => <HomeState>[
        HomeLoadingState(),
        HomeSuccessState(const CarInformation(), suggestions),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoadingState, HomeErrorWithExtraState] when searchCarByVinNumber has InternalApiError',
      build: () => HomeCubit(searchCarByVinNumber),
      act: (cubit) async {
        when(() => searchCarByVinNumber("")).thenThrow(internalApiError);
        await cubit.searchByVin("");
      },
      expect: () => <HomeState>[
        HomeLoadingState(),
        HomeErrorWithExtraState(
          internalApiError.message,
          internalApiError.extraError,
        )
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoadingState, HomeErrorState] when searchCarByVinNumber has generic ApiError',
      build: () => HomeCubit(searchCarByVinNumber),
      act: (cubit) async {
        when(() => searchCarByVinNumber("")).thenThrow(Failure(""));
        await cubit.searchByVin("");
      },
      expect: () => <HomeState>[HomeLoadingState(), HomeErrorState("")],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoadingState, HomeErrorState] when searchCarByVinNumber has strange error',
      build: () => HomeCubit(searchCarByVinNumber),
      act: (cubit) async {
        when(() => searchCarByVinNumber(""))
            .thenThrow(Exception("Some exception"));
        await cubit.searchByVin("");
      },
      expect: () => <HomeState>[
        HomeLoadingState(),
        HomeErrorState("Please contact support.")
      ],
    );
  });
}

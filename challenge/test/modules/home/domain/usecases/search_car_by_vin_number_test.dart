import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/domain/errors/home_errors.dart';
import 'package:challenge/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:challenge/app/modules/home/domain/services/home_service_interface.dart';
import 'package:challenge/app/modules/home/domain/usecases/search_car_by_vin_number.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements IHomeRepository {}

class MockHomeService extends Mock implements IHomeService {}

void main() {
  late String vin;
  late IHomeService service;
  late CarInformation carInformation;
  late MockHomeRepository repository;
  late List<CarAdditionalInfo> suggestions;
  late ISearchCarByVinNumber searchCarByVinNumber;

  setUpAll(() {
    setUpTestHive();
    service = MockHomeService();
    repository = MockHomeRepository();
    searchCarByVinNumber = SearchCarByVinNumber(repository, service);
    vin = "DE00301860145002A";
    carInformation = CarInformation(
      externalId: vin,
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

  group('SearchCarByVinNumber', () {
    test('should return and save CarInformation if data exist', () async {
      when(() => repository.searchCarByVin(vin)).thenAnswer(
        (_) async => (carInformation, <CarAdditionalInfo>[]),
      );

      when(() => service.saveCarInformation(carInformation)).thenAnswer(
        (_) async => true,
      );

      when(() => service.getCarInformation()).thenAnswer(
        (_) async => carInformation,
      );

      final response = await searchCarByVinNumber(vin);
      expect(response.$1, isA<CarInformation>());
    });

    test('should return and save List<CarAdditionalInfo> if data exist',
        () async {
      when(() => repository.searchCarByVin(vin)).thenAnswer(
        (_) async => (const CarInformation(), suggestions),
      );

      when(() => service.saveCarInformation(carInformation)).thenAnswer(
        (_) async => true,
      );

      when(() => service.saveSuggestions(suggestions)).thenAnswer(
        (_) async => true,
      );

      when(() => service.getCarInformation()).thenAnswer(
        (_) async => carInformation,
      );

      final response = await searchCarByVinNumber(vin);
      expect(response.$2, isA<List<CarAdditionalInfo>>());
    });

    test('should return an Exception when VinCode is empty', () async {
      when(() => repository.searchCarByVin("")).thenThrow(VinCodeEmpty());
      expect(() async => await searchCarByVinNumber(""),
          throwsA(isA<VinCodeEmpty>()));
    });
  });
}

import 'dart:async';
import 'dart:convert';

import 'package:challenge/app/core/domain/errors/api_errors.dart';
import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/modules/home/infra/repositories/home_repository.dart';
import 'package:challenge/app/utils/cos_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

class MockHttpClient extends Mock implements BaseClient {}

void main() {
  late MockHttpClient httpClient;
  late HomeRepository repository;
  late String vin;
  late Uri uri;
  late Map<String, String> headers;

  setUpAll(() {
    httpClient = MockHttpClient();
    repository = HomeRepository(httpClient);
    vin = "DE002-018601450020001";
    uri = Uri.https('anyUrl');
    headers = {
      CosChallenge.user: 'someUserId',
    };
  });

  group('SearchCarByVin - Success', () {
    test(
        'should return the Record when the Json has correct behavior status 200',
        () async {
      when(() => httpClient.get(
            uri,
            headers: headers,
          )).thenAnswer(
        (_) async => Response(
          carInformationWithCorrectJsonFormat,
          200,
        ),
      );

      final response = await repository.searchCarByVin(vin);
      expect(response, isA<(CarInformation, List<CarAdditionalInfo>)>());
      expect(response.$1.id.isNotEmpty, response.$1.id.isNotEmpty);
      expect(response.$2.isEmpty, response.$2.isEmpty);
    });

    test(
        'should return the Record when the Json has correct behavior status 300',
        () async {
      when(() => httpClient.get(
            uri,
            headers: headers,
          )).thenAnswer(
        (_) async => Response(
          multiplesOptionsStatus300,
          300,
        ),
      );

      final response = await repository.searchCarByVin(vin);
      expect(response, isA<(CarInformation, List<CarAdditionalInfo>)>());
      expect(response.$1.id.isEmpty, response.$1.id.isEmpty);
      expect(response.$2.isNotEmpty, response.$2.isNotEmpty);
    });
  });

  group('SearchCarByVin - Forced Errors with Data', () {
    test('should return the InternalApiError when error 400 happens on the Api',
        () async {
      when(() => httpClient.get(
            uri,
            headers: headers,
          )).thenAnswer(
        (_) async => Response(
          error400,
          400,
        ),
      );
      expect(() async => await repository.searchCarByVin(vin),
          throwsA(isA<InternalApiError>()));
    });

    test(
        'should return the IncorrectJsonFormat as Failure when Json Has incorrect format',
        () async {
      when(() => httpClient.get(
            uri,
            headers: headers,
          )).thenAnswer(
        (_) async => jsonDecode(carInformationWithWrongJsonFormat),
      );
      expect(() async => await repository.searchCarByVin(vin),
          throwsA(isA<IncorrectJsonFormat>()));
    });
  });

  group('SearchCarByVin - Forced Exceptions', () {
    test(
        'should return the IncorrectJsonFormat as Failure when FormatException',
        () async {
      when(() => httpClient.get(
            uri,
            headers: headers,
          )).thenThrow(const FormatException());
      expect(
        () async => await repository.searchCarByVin(vin),
        throwsA(isA<IncorrectJsonFormat>()),
      );
    });

    test('should return the TimeoutApi as Failure when TimeoutException',
        () async {
      when(() => httpClient.get(
            uri,
            headers: headers,
          )).thenThrow(TimeoutException(""));
      expect(
        () async => await repository.searchCarByVin(vin),
        throwsA(isA<TimeoutApi>()),
      );
    });

    test('should return the InternalApiError as Failure when InternalApiError',
        () async {
      when(() => httpClient.get(
            uri,
            headers: headers,
          )).thenThrow(InternalApiError(null));
      expect(
        () async => await repository.searchCarByVin(vin),
        throwsA(isA<InternalApiError>()),
      );
    });
  });
}

import 'dart:convert';

import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/mocks.dart';

void main() {
  group('CarInformation', () {
    test('should fromJson creates instance with correct properties', () {
      final carInformation = CarInformation.fromJson(
          jsonDecode(carInformationWithCorrectJsonFormat));
      expect(carInformation.make, 'Toyota');
      expect(carInformation.model, 'GT 86 Basis');
      expect(carInformation.externalId, 'DE003-018601450020008');
    });

    test('should toJson returns correct map with properties', () {
      final carAdditionalInfo = CarInformation.fromJson(
          jsonDecode(carInformationWithCorrectJsonFormat));
      final json = carAdditionalInfo.toJson();
      expect(json['make'], 'Toyota');
      expect(json['model'], 'GT 86 Basis');
      expect(json['externalId'], 'DE003-018601450020008');
    });
  });
}

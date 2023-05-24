import 'dart:convert';

import 'package:challenge/app/core/domain/models/car_additional_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/mocks.dart';

void main() {
  group('CarAdditionalInfo', () {
    test('should fromJson creates instance with correct properties', () {
      final carAdditionalInfo =
          CarAdditionalInfo.fromJson(jsonDecode(oneOptionStatus300));
      expect(carAdditionalInfo.make, 'Toyota');
      expect(carAdditionalInfo.model, 'GT 86 Basis');
      expect(carAdditionalInfo.similarity, 98);
    });

    test('should toJson returns correct map with properties', () {
      final carAdditionalInfo =
          CarAdditionalInfo.fromJson(jsonDecode(oneOptionStatus300));
      final json = carAdditionalInfo.toJson();
      expect(json['make'], 'Toyota');
      expect(json['model'], 'GT 86 Basis');
      expect(json['externalId'], 'DE003-018601450020001');
    });
  });
}

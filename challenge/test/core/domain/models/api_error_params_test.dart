import 'dart:convert';

import 'package:challenge/app/core/domain/models/api_error_params.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/mocks.dart';

void main() {
  group('ApiErrorParams', () {
    test('sould fromJson creates instance with correct delaySeconds value', () {
      final apiErrorParams =
          ApiErrorParams.fromJson(jsonDecode(paramsError400));
      expect(apiErrorParams.delaySeconds, 1337);
    });

    test('sould toJson returns correct map with delaySeconds', () {
      final apiErrorParams = ApiErrorParams(delaySeconds: 10);
      final json = apiErrorParams.toJson();
      expect(json['delaySeconds'], 10);
    });

    test('sould hasDelay is true when delaySeconds is non-zero', () {
      final apiErrorParams = ApiErrorParams(delaySeconds: 15);
      expect(apiErrorParams.hasDelay, true);
    });

    test('sould hasDelay is false when delaySeconds is zero', () {
      final apiErrorParams = ApiErrorParams(delaySeconds: 0);
      expect(apiErrorParams.hasDelay, false);
    });
  });
}

import 'dart:convert';

import 'package:challenge/app/core/domain/models/api_error.dart';
import 'package:challenge/app/core/domain/models/api_error_params.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/mocks.dart';

void main() {
  group('ApiError', () {
    test('should fromJson creates instance with correct properties', () {
      final apiError = ApiError.fromJson(jsonDecode(error400));
      expect(apiError.msgKey, 'maintenance');
      expect(apiError.message, 'Please try again in 1337 seconds');
      expect(apiError.params.delaySeconds, 1337);
    });

    test('toJson returns correct map with properties', () {
      final apiError = ApiError(
        msgKey: 'maintenance',
        message: 'Please try again in 1337 seconds',
        params: ApiErrorParams(delaySeconds: 1337),
      );
      final json = apiError.toJson();
      expect(json['msgKey'], 'maintenance');
      expect(json['message'], 'Please try again in 1337 seconds');
      expect(json['params'], {'delaySeconds': 1337});
    });
  });
}

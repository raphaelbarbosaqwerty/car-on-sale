import 'package:challenge/app/core/domain/validators/text_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextFormValidator', () {
    test('validateFieldEmpty returns null on non-empty string', () {
      expect(TextFormValidator.validateFieldEmpty("hello"), isNull);
    });

    test('validateFieldEmpty returns message on empty string', () {
      expect(
        TextFormValidator.validateFieldEmpty("", message: "Custom Message"),
        equals("Custom Message"),
      );
    });

    test('validateFieldEmail returns null on valid email', () {
      expect(
        TextFormValidator.validateFieldEmail("email@example.com"),
        isNull,
      );
    });

    test('validateFieldEmail returns message on empty email', () {
      expect(
        TextFormValidator.validateFieldEmail(
          "",
          message: "Custom Email Message",
        ),
        equals("Custom Email Message"),
      );
    });

    test('validateFieldEmail returns message on invalid email', () {
      expect(
        TextFormValidator.validateFieldEmail("invalid"),
        equals("Email invalid"),
      );
    });

    test('validateFieldEmail returns custom message on invalid email', () {
      expect(
        TextFormValidator.validateFieldEmail(
          "invalid",
          message: "Custom Invalid Email Message",
        ),
        equals("Custom Invalid Email Message"),
      );
    });
  });
}
